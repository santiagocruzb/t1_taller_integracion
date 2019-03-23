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
        @main = respuesta


    end

end
