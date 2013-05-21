Rails.application.routes.draw do
  mount Discussion::Engine => "/discussion", as: 'discussion'

  resources :assignments do
    resources :threads, :module => "discussion"
    resources :comments, :module => "discussion"
  end

end