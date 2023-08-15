# frozen_string_literal: true

class Editorjs::Text < Editorjs::ApplicationRecord
  self.table_name = "editorjs_rails_texts"

  belongs_to :record, polymorphic: true, touch: true
  has_many_attached :images

  serialize :content, Editorjs::Text::Content
  delegate :to_h, :as_json, :to_json, :to_markdown, to: :content

  after_save :cleanup!, if: :saved_change_to_content?

  private

  def cleanup!
    images.each do |attachment|
      attachment.destroy unless content.has_image?(attachment.url)
    end
  end
end
