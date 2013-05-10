Rails.application.routes.draw do
  mount Discussion::Engine => "/discussion", as: 'discussion'

  resources :assignments do
    resources :threads, :module => "discussion"
  end

end