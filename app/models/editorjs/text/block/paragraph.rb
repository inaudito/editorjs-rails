# frozen_string_literal: true

class Editorjs::Text::Block::Paragraph < Editorjs::Text::Block
  attr_reader :text

  def initialize(**options)
    super

    @text = @data["text"]
  end

  def to_html
    tag.p(@text.html_safe)
  end
end
