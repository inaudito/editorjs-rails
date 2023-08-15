# frozen_string_literal: true

module Editorjs
  class Engine < Rails::Engine
    isolate_namespace Editorjs
    config.eager_load_namespaces << Editorjs

    initializer "editorjs-rails.attribute" do
      ActiveSupport.on_load(:active_record) do
        include Editorjs::Attribute
      end
    end

    initializer "editorjs-rails.asset" do
      if Rails.application.config.respond_to?(:assets)
        Rails.application.config.assets.precompile += %w(editorjs-rails.js)
      end
    end

    initializer "editorjs-rails.helper" do
      %i[action_controller_base action_mailer].each do |abstract_controller|
        ActiveSupport.on_load(abstract_controller) do
          helper Editorjs::Engine.helpers
        end
      end
    end
  end
end
