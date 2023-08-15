Editorjs::Engine.routes.draw do
  post "texts/:id/upload_image", to: "texts#upload_image", as: :upload_image
end
