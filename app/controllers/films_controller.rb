class FilmsController < ApplicationController
    def index

    end

    def show
        numero = params[:id]
        url = "https://swapi.co/api/films/"
        url = url.concat(numero)
        respuesta = RestClient.get url
        respuesta = JSON.parse(respuesta)
        @main = respuesta
        puts url


    end

end
