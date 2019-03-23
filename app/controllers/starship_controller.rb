class StarshipController < ApplicationController
  def show
    numero = params[:id]
    url = "https://swapi.co/api/starships/".concat(numero)
    respuesta = RestClient.get url
    respuesta = JSON.parse(respuesta)
    @general = respuesta

    threads_personajes = []
    info_personajes = []
    personajes = respuesta['pilots']
    personajes.each do |p|
        threads_personajes << Thread.new{
            info = RestClient.get p
            info = JSON.parse(info)
            info_personajes << info
            }
    end
    threads_personajes.each(&:join)
    @characters = info_personajes

    threads_peliculas = []
    info_peliculas = []
    peliculas = respuesta['films']
    peliculas.each do |n|
        threads_peliculas << Thread.new{
            info = RestClient.get n
            info = JSON.parse(info)
            info_peliculas << info
        }    
    end
    threads_peliculas.each(&:join)
    @films = info_peliculas

  end
end
