Editorjs::Engine.routes.draw do
  resource :images, only: %i[create]
end
