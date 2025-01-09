# frozen_string_literal: true

class Editorjs::Text::Block::Raw < Editorjs::Text::Block
  attr_reader :html

  def initialize(**options)
    super

    @html = @data["html"]
  end

  def to_html
    html.html_safe
  end
end
