Discussion::Engine.routes.draw do
  resources :threads do
    resources :messages
  end
  root :to => "threads#index"
end