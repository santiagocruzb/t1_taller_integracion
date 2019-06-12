class StarshipController < ApplicationController
  def index
    url = "https://swapi.co/api/starships/"
    respuesta = RestClient.get url
    respuesta = JSON.parse(respuesta)
    cantidad = respuesta["count"].to_f
    paginas = cantidad / 10.0
    paginas = paginas.ceil

    threads = []
    resultados_paginas = []
    (1..paginas).each do |numero|
      threads << Thread.new{
        url = "https://swapi.co/api/starships/"
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
    a_retornar = a_retornar.sort_by { |k| k["id"].to_i }
    @starships = a_retornar
  end



  def show
    id_starship = params[:id]
    puts id_starship
    query = 'query {allStarships { edges {node {name id model manufacturers costInCredits length crew passengers cargoCapacity consumables pilotConnection{edges {node {id name}}} filmConnection{ edges {node {id title}}}}}}}'
    respuesta = RestClient.get "https://swapi-graphql-integracion-t3.herokuapp.com/", {params: {'query' => query}}
    respuesta = JSON.parse(respuesta)
    all_starship = respuesta['data']['allStarships']['edges']
    # puts all_vehicles
    founded = nil
    all_starship.each do |starship|
      if starship['node']['id'] == id_starship
        founded = starship['node']
        puts "encontradoooo"
        break
      end
    end
    puts founded
    @general = founded
  end
end
