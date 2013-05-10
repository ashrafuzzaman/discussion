Discussion::Engine.routes.draw do
  resources :threads do
    resources :messages
  end
end