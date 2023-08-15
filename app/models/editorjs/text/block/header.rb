# frozen_string_literal: true

class Editorjs::Text::Block::Header < Editorjs::Text::Block
  attr_reader :text, :level

  def initialize(**options)
    super

    @text = @data["text"]
    @level = @data["level"]
  end

  def to_markdown
    ["#" * @level, @text].join(" ")
  end
end
