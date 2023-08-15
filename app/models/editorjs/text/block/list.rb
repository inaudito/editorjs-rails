# frozen_string_literal: true

class Editorjs::Text::Block::List < Editorjs::Text::Block
  attr_reader :items, :style

  def initialize(**options)
    super

    @items = @data["items"]
    @style = @data["style"]
  end

  def to_markdown
    @items.map { |options| render_list([options]) }.join
  end

  private

  def render_list(items)
    return "" unless items.present?

    helpers.content_tag(@style == "ordered" ? "ol" : "ul") do
      items.map { |item_options| render_list_item(item_options["content"], item_options["items"]) }.join.html_safe
    end
  end

  def render_list_item(content, items = [])
    helpers.tag.li { (content + render_list(items)).html_safe }
  end
end
