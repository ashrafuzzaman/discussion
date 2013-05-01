Discussion::Engine.routes.draw do
  resources :threads
  root :to => "threads#index"
end