require 'rest-client'
require 'json'

class StaticPagesController < ApplicationController
  def home
    respuesta = RestClient.get "https://swapi.co/api/films"
    respuesta = JSON.parse(respuesta)
    @response = respuesta['results'].sort_by { |k| k["episode_id"] }
    query = 'query { allFilms { edges { node { id producers title episodeID director} } } }'
    respuesta = RestClient.get "https://swapi-graphql-integracion-t3.herokuapp.com/", {params: {'query' => query}}

    
    respuesta = JSON.parse(respuesta)
    # respuesta = respuesta['resu']
    all_films = respuesta['data']['allFilms']['edges']
    @response = all_films
    # puts 
  end

  def help
  end
end
