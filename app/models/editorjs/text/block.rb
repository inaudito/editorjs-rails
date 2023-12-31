# frozen_string_literal: true

class Editorjs::Text::Block
  attr_reader :id, :type, :data

  def initialize(**options)
    @id = options["id"]
    @type = options["type"]
    @data = options["data"]
  end

  def to_html
  end

  def helpers
    Editorjs::ApplicationController.helpers
  end

  delegate_missing_to :helpers
end
