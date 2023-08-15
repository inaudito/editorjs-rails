# frozen_string_literal: true

class Editorjs::Text::Block::Image < Editorjs::Text::Block
  attr_reader :caption, :url

  def initialize(**options)
    super

    @caption = @data["caption"]
    @url = @data.dig("file", "url")
  end

  def to_markdown
    "![#{@caption}](#{@url})"
  end
end
