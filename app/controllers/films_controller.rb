class FilmsController < ApplicationController
    def index

    end

    def show
        # vamos a mantener el order segun las originales
        # la primera es la nueva esperanza y asi..
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

        # especies = respuesta['species']

        # threads_especies = []
        # info_especies = []
        # especies = respuesta['starships']
        # especies.each do |n|
        #     threads_especies << Thread.new{
        #         info = RestClient.get n
        #         info = JSON.parse(info)
        #         info_especies << info
        #     }    
        # end
        # threads_especies.each(&:join)


        # @personajes = info_personajes

        # puts "info personajes:"
        # puts info_personajes
        # puts ""
        # puts 
        # puts "info naves:"
        # puts info_naves
        # puts ""
        # puts 
        # puts "info especies:"
        # puts info_especies
        # puts ""
        # puts 
        
        
        # thread = Thread.new{ RestClient.get "https://swapi.co/api/people/1/"}
        # puts thread
        
        # sleep(10)

    end

end
