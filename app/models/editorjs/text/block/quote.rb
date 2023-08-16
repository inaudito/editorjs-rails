# frozen_string_literal: true

class Editorjs::Text::Block::Quote < Editorjs::Text::Block
  attr_reader :text, :caption

  def initialize(**options)
    super

    @text = @data["text"]
    @caption = @data["caption"]
  end

  def to_html
    tag.blockquote do
      concat @text.html_safe
      concat tag.cite(@caption.html_safe)
    end
  end
end
