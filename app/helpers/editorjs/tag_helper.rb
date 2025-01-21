# frozen_string_literal: true

module Editorjs
  module TagHelper
    cattr_accessor(:id, instance_accessor: false) { 0 }

    def editorjs_text_area_tag(name, value = nil, options = {})
      options = options.symbolize_keys
      form = options.delete(:form)

      options[:class] = "editorjs"
      options[:input] ||= "editorjs_rails_input_#{Editorjs::TagHelper.id += 1}"

      options[:data] ||= {}
      options[:data][:input] ||= options.delete(:input)
      options[:data][:authenticity_token] ||= form_authenticity_token
      options[:data][:record_type] = value.record_type
      options[:data][:record_id] = value.record_id
      options[:data][:name] = value.name
      options[:data][:upload_image_url] = Editorjs::Engine.routes.url_helpers.images_path

      editor_tag = content_tag("div", "", options)
      input_tag = hidden_field_tag(name, value.to_json, id: options[:data][:input], form: form)

      input_tag + editor_tag
    end
  end
end

module ActionView::Helpers
  class Tags::Editorjs < Tags::Base
    delegate :dom_id, to: ActionView::RecordIdentifier

    def render
      options = @options.stringify_keys
      add_default_name_and_id(options)
      options["input"] ||= dom_id(object, [options["id"], :editorjs].compact.join("_")) if object
      @template_object.editorjs_text_area_tag(options.delete("name"), options.fetch("value") { value }, options.except("value"))
    end
  end

  module FormHelper
    def editorjs_text_area(object_name, method, options = {})
      Tags::Editorjs.new(object_name, method, self, options).render
    end
  end

  class FormBuilder
    def editorjs_text_area(method, options = {})
      @template.editorjs_text_area(@object_name, method, objectify_options(options))
    end
  end
end
