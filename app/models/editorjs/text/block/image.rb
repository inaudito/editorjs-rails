# frozen_string_literal: true

class Editorjs::Text::Block::Image < Editorjs::Text::Block
  attr_reader :caption, :url

  def initialize(**options)
    super

    @caption = @data["caption"]
    @url = @data.dig("file", "url")
  end

  def to_html
    caption = strip_tags(@caption)

    tag.figure do
      concat image_tag(@url, alt: caption, title: caption, width: "100%")
      concat tag.figcaption(caption)
    end
  end
end
