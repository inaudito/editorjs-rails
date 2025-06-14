# frozen_string_literal: true

class Editorjs::ImagesController < Editorjs::ApplicationController
  before_action :set_text, only: %i[create]

  def create
    image_url = if params.key?(:image)
        attach_image(params[:image])
      elsif params.key?(:url)
        download_and_attach_image(params[:url])
      end

    if image_url.present?
      render status: :ok, json: {
        success: 1,
        file: { url: image_url },
      }
    else
      render status: :unprocessable_entity, json: {
        success: 0,
        file: nil,
      }
    end
  end

  private

  def attach_image(uploaded_file)
    if @text.images.attach(uploaded_file)
      image = @text.images.order(created_at: :desc).take
      Rails.application.routes.url_helpers.url_for(image) if image.present?
    end
  end

  def download_and_attach_image(url)
    tempfile = Tempfile.new(encoding: "ascii-8bit")
    filename = Addressable::URI.parse(url).basename
    response = Faraday.get(url)

    if response.success?
      tempfile.write(response.body)
      uploaded_file = ActionDispatch::Http::UploadedFile.new(tempfile: tempfile, filename: filename)

      attach_image(uploaded_file)
    end
  ensure
    tempfile.close
    tempfile.unlink
  end

  def set_text
    @text = Editorjs::Text.find_or_create_by(text_params)
  end

  def text_params
    params.permit(:record_type, :record_id, :name)
  end
end
