# frozen_string_literal: true

module Editorjs::Attribute
  extend ActiveSupport::Concern

  class_methods do
    def has_text(name)
      class_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{name}
          text_#{name} || build_text_#{name}
        end

        def #{name}?
          text_#{name}.present?
        end

        def #{name}=(content)
          self.#{name}.content = content
        end
      CODE

      has_one :"text_#{name}", -> { where(name: name) }, class_name: "Editorjs::Text", as: :record, inverse_of: :record, autosave: true, dependent: :destroy
    end
  end
end
