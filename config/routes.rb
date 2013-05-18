Discussion::Engine.routes.draw do
  resources :threads do
    resources :comments
  end
end