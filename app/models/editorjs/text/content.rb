# frozen_string_literal: true

class Editorjs::Text::Content
  def self.load(content)
    new(content) if content
  end

  def self.dump(content)
    case content
    when nil
      nil
    when self
      content.to_h
    when Editorjs::Text
      content.data.to_h
    when String
      ActiveSupport::JSON.decode(content)
    else
      new(content).to_h
    end
  end

  def initialize(options = {})
    @options = options
    @time = options["time"]
    @blocks = options["blocks"] || []
    @version = options["version"]
  end

  attr_reader :time, :blocks, :version
  delegate :to_h, :as_json, :to_json, to: :@options
  delegate :empty?, to: :@blocks

  def self.block_types
    @block_types ||= {}.with_indifferent_access
  end

  def self.register_block_type(type, klass)
    block_types[type] = klass
  end

  register_block_type :paragraph, Editorjs::Text::Block::Paragraph
  register_block_type :header, Editorjs::Text::Block::Header
  register_block_type :image, Editorjs::Text::Block::Image
  register_block_type :list, Editorjs::Text::Block::List
  register_block_type :quote, Editorjs::Text::Block::Quote
  register_block_type :delimiter, Editorjs::Text::Block::Delimiter

  def blocks
    @blocks.map do |options|
      block_type = self.class.block_types[options["type"]] || Editorjs::Text::Block
      block_type.new(**options)
    end
  end

  def to_html
    blocks.map(&:to_html).compact_blank.join.html_safe
  end

  def has_image?(url)
    blocks
      .filter { |block| block.type == "image" }
      .any? { |block| block.url == url }
  end
end
