class MainController < ApplicationController
    def index
    end

    def search

        convertidor = { "1" => "4", 
            "2" => "5", 
            "3" => "6", 
            "4" => "1", 
            "5" => "2", 
            "6" => "3", 
            "7" => "7" }

        termino = params[:q]
        threads = []

        @characters = []
        @planets = []
        @films = []
        @starships = []

        threads << Thread.new{
            url = "https://swapi.co/api/people/"
            respuesta =  RestClient.get url, {params: {'search' => termino}}
            respuesta = JSON.parse(respuesta)
            respuesta['results'].first(5).each do |p|
                local = {"name" => p['name'], "url"=> 'characters/'.concat(p['url'].split('/')[-1])}
                @characters << local
            end
        }
        

        threads << Thread.new{
            url = "https://swapi.co/api/planets/"
            respuesta =  RestClient.get url, {params: {'search' => termino}}
            respuesta = JSON.parse(respuesta)
            respuesta['results'].first(5).each do |p|
                local = {"name" => p['name'], "url" =>  'planets/'.concat(p['url'].split('/')[-1])}
                @planets << local
            end
        }
        

        threads << Thread.new{
            url = "https://swapi.co/api/films/"
            respuesta =  RestClient.get url, {params: {'search' => termino}}
            respuesta = JSON.parse(respuesta)
            respuesta['results'].first(5).each do |p|
                local = {"name" => p['title'], "url" => 'films/'.concat(convertidor[p['url'].split('/')[-1]])}
                @films << local
            end
        }
        


        threads << Thread.new{
            url = "https://swapi.co/api/starships/"
            respuesta =  RestClient.get url, {params: {'search' => termino}}
            respuesta = JSON.parse(respuesta)
            respuesta['results'].first(5).each do |p|
                local = {"name" => p['name'], "url" =>  'starships/'.concat(p['url'].split('/')[-1])}
                @starships << local
            end
        }
        threads.each(&:join)

        respond_to do |format|
            format.html{}
            format.json{
                @films
                @characters.to_json
                @planets.to_json
                @starships.to_json
            }
        end
    end

end
