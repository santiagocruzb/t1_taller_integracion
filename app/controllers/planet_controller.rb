class PlanetController < ApplicationController

    def index
        url = "https://swapi.co/api/planets/"
        respuesta = RestClient.get url
        respuesta = JSON.parse(respuesta)
        cantidad = respuesta["count"].to_f
        paginas = cantidad / 10.0
        paginas = paginas.ceil

        threads = []
        resultados_paginas = []
        (1..paginas).each do |numero|
        threads << Thread.new{
            url = "https://swapi.co/api/planets/"
            respuesta = RestClient.get url, {params: {'page' => numero}}
            respuesta = JSON.parse(respuesta)
            datos = respuesta["results"]
            resultados_paginas << datos
        }
        end

        a_retornar = []
        threads.each(&:join)
        resultados_paginas.each do |pagina|
            pagina.each do |resultado|
                local = {"name" => resultado["name"], "id" => resultado["url"].split('/')[-1]}
                a_retornar << local
            end
        end
        @planets = a_retornar.sort_by { |k| k["id"].to_i }
  
        
    end


    def show
        numero = params[:id]
        url = "https://swapi.co/api/planets/".concat(numero)
        respuesta = RestClient.get url
        respuesta = JSON.parse(respuesta)
        @general = respuesta

        threads_personajes = []
        info_personajes = []
        personajes = respuesta['residents']
        personajes.each do |p|
            threads_personajes << Thread.new{
                info = RestClient.get p
                info = JSON.parse(info)
                info_personajes << info
                }
        end
        threads_personajes.each(&:join)
        @characters = info_personajes.sort_by { |k| k["url"].split('/')[-1].to_i }


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
        @films = info_peliculas.sort_by { |k| k["episode_id"].to_i }

    end

end
