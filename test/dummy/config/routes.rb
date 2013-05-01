Rails.application.routes.draw do

  mount Discussion::Engine => "/discussion"
end