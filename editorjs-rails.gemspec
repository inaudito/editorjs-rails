require_relative "lib/editorjs/version"

Gem::Specification.new do |spec|
  spec.name = "editorjs-rails"
  spec.version = Editorjs::VERSION
  spec.authors = ["IN AUDITO GmbH"]
  spec.email = ["entwicklung@inaudito.de"]
  spec.homepage = "https://www.inaudito.de"
  spec.summary = "Editor.js integration for Rails"
  spec.description = "Editor.js integration for Rails"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{lib,app,config,db}/**/*", "Rakefile", "package.json"]
  end
  spec.require_path = "lib"

  spec.add_dependency "rails", ">= 7.1"
  spec.add_dependency "addressable", "~> 2.8"
  spec.add_dependency "faraday", "~> 2.10"
end
