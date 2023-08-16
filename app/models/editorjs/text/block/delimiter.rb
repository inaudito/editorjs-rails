# frozen_string_literal: true

class Editorjs::Text::Block::Delimiter < Editorjs::Text::Block
  def to_html
    tag.hr
  end
end
