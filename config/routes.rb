Rails.application.routes.draw do
  get :search, controller: :main
  # get 'specie/show'

  # get 'character/show'

  # get 'starship/show'

  get  '/help',    to: 'static_pages#help', as: 'help'


  root 'static_pages#home'


  get '/films', to: 'static_pages#home'
  get  '/films/:id', to: 'films#show', as: 'film'

  get '/starships', to: 'starship#index', as: 'starships'
  get '/starships/:id', to: 'starship#show', as: 'starship'

  get '/planets', to: 'planet#index', as: 'planets'
  get '/planets/:id', to: 'planet#show', as: 'planet'

  get '/characters', to: 'character#index', as: 'characters'
  get '/characters/:id', to: 'character#show', as: 'character'

  
  
end
