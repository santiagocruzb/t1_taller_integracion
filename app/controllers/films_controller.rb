class FilmsController < ApplicationController
    def index
        respuesta = RestClient.get "https://swapi.co/api/films"
    
        respuesta = JSON.parse(respuesta)
    
        @response = respuesta['results'].sort_by { |k| k["episode_id"] }

    end

    def show
        convertidor = { "1" => "4", 
            "2" => "5", 
            "3" => "6", 
            "4" => "1", 
            "5" => "2", 
            "6" => "3", 
            "7" => "7" }
        numero_falso = params[:id]
        numero = convertidor[numero_falso]
        url = "https://swapi.co/api/films/"
        url = url.concat(numero)
        respuesta = RestClient.get url
        respuesta = JSON.parse(respuesta)
        @general = respuesta

        # codigo modificado desde https://ronanlopes.me/threads-ruby-sending-parallel-http-requests/

        threads_personajes = []
        info_personajes = []
        personajes = respuesta['characters']
        personajes.each do |p|
            threads_personajes << Thread.new{
                info = RestClient.get p
                info = JSON.parse(info)
                info_personajes << info
                }
        end
        threads_personajes.each(&:join)
        @characters = info_personajes

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

        threads_planetas = []
        info_planetas = []
        planetas = respuesta['planets']
        planetas.each do |n|
            threads_planetas << Thread.new{
                info = RestClient.get n
                info = JSON.parse(info)
                info_planetas << info
            }    
        end
        threads_planetas.each(&:join)
        @planets = info_planetas

    end

end
