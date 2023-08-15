# frozen_string_literal: true

class Editorjs::TextsController < Editorjs::ApplicationController
  before_action :set_text, only: %i[upload_image]

  def upload_image
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
      @text.images.order(created_at: :desc).take&.url
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
    @text = Editorjs::Text.find(params[:id])
  end
end
