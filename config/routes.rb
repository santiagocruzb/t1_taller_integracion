Rails.application.routes.draw do
  get :search, controller: :main
  get 'specie/show'
  get 'character/show'
  get 'starship/show'
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help', as: 'help'

  get  '/films', to: 'films#index'
  get  '/films/:id', to: 'films#show', as: 'film'

  get '/starships/:id', to: 'starship#show', as: 'starship'

  get '/planets/:id', to: 'planet#show', as: 'planet'

  get '/characters/:id', to: 'character#show', as: 'character'

  
  
  
  # resources :films
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
