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

        id_film = params[:id]
        # puts id_film
        query = 'query { allFilms { edges { node { title releaseDate director producers openingCrawl id characterConnection { edges { node { id name }}} starshipConnection { edges { node { id name }}} planetConnection { edges { node { id name }}}}}}}'
        respuesta = RestClient.get "https://swapi-graphql-integracion-t3.herokuapp.com/", {params: {'query' => query}}
        respuesta = JSON.parse(respuesta)
        all_films = respuesta['data']['allFilms']['edges']
        founded = nil
        all_films.each do |film|
            if film['node']['id'] == id_film
                film['node']
                founded = film['node']
                break
            end
        end
        @general =  founded

        # @general = founded
        # puts respuesta  

        # numero_falso = params[:id]
        # numero = convertidor[numero_falso]
        # url = "https://swapi.co/api/films/"
        # url = url.concat(numero)
        # respuesta = RestClient.get url
        # respuesta = JSON.parse(respuesta)
        # @general = respuesta

        # # codigo modificado desde https://ronanlopes.me/threads-ruby-sending-parallel-http-requests/

        # threads_personajes = []
        # info_personajes = []
        # personajes = respuesta['characters']
        # personajes.each do |p|
        #     threads_personajes << Thread.new{
        #         info = RestClient.get p
        #         info = JSON.parse(info)
        #         info_personajes << info
        #         }
        # end
        # threads_personajes.each(&:join)
        # @characters = info_personajes.sort_by { |k| k["url"].split('/')[-1].to_i }

        # threads_naves = []
        # info_naves = []
        # naves = respuesta['starships']
        # naves.each do |n|
        #     threads_naves << Thread.new{
        #         info = RestClient.get n
        #         info = JSON.parse(info)
        #         info_naves << info
        #     }    
        # end
        # threads_naves.each(&:join)
        # @starships = info_naves.sort_by { |k| k["url"].split('/')[-1].to_i }

        # threads_planetas = []
        # info_planetas = []
        # planetas = respuesta['planets']
        # planetas.each do |n|
        #     threads_planetas << Thread.new{
        #         info = RestClient.get n
        #         info = JSON.parse(info)
        #         info_planetas << info
        #     }    
        # end
        # threads_planetas.each(&:join)
        # @planets = info_planetas.sort_by { |k| k["url"].split('/')[-1].to_i }

    end

end
