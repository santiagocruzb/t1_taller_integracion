class CharacterController < ApplicationController

  def index
    url = "https://swapi.co/api/people/"
    respuesta = RestClient.get url
    respuesta = JSON.parse(respuesta)
    cantidad = respuesta["count"].to_f
    paginas = cantidad / 10.0
    paginas = paginas.ceil

    threads = []
    resultados_paginas = []
    (1..paginas).each do |numero|
      threads << Thread.new{
        url = "https://swapi.co/api/people/"
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
    a_retornar = a_retornar.sort_by { |k| k["id"] }
    @characters = a_retornar
  end

  def show
    id_character = params[:id]
    query = 'query { allPeople { edges { node { name height mass id gender birthYear hairColor  filmConnection { edges { node { id title } } } starshipConnection { edges { node { id name }}}}}}}'
    respuesta = RestClient.get "https://swapi-graphql-integracion-t3.herokuapp.com/", {params: {'query' => query}}
    respuesta = JSON.parse(respuesta)
    all_characters = respuesta['data']['allPeople']['edges']
    founded = nil
    all_characters.each do |char|
      if char['node']['id'] == id_character
        founded = char['node']
        break
      end
    end
    puts founded
    @general = founded

 
  end
end
