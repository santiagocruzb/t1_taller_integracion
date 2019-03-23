class CharacterController < ApplicationController

  def show
    numero = params[:id]
    url = "https://swapi.co/api/people/".concat(numero)
    respuesta = RestClient.get url
    respuesta = JSON.parse(respuesta)
    @general = respuesta


    threads_naves = []
    info_naves = []
    naves = respuesta['starships']
    naves.each do |n|
        threads_naves << Thread.new{
            info = RestClient.get n
            info = JSON.parse(info)
            info_naves << info
        }    
    end
    threads_naves.each(&:join)
    @starships = info_naves



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
