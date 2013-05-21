Discussion::Engine.routes.draw do
  resources :threads do
    resources :comments, except: [:show]
  end
end