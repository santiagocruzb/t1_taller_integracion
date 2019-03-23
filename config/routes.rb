Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help', as: 'help'

  get  '/films', to: 'films#index'
  get  '/films/:id', to: 'films#show'
  
  # resources :films
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
