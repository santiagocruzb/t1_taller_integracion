require 'rest-client'
require 'json'

class StaticPagesController < ApplicationController
  def home
    respuesta = RestClient.get "https://swapi.co/api/films"

    respuesta = JSON.parse(respuesta)

    @response = respuesta['results'].sort_by { |k| k["episode_id"] }

  end

  def help
  end
end
