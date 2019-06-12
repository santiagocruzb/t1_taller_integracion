class StarshipController < ApplicationController
  def index

    query = 'query {allStarships { edges {node {name id }}}}'
    respuesta = RestClient.get "https://swapi-graphql-integracion-t3.herokuapp.com/", {params: {'query' => query}}
    respuesta = JSON.parse(respuesta)
    @starships = respuesta['data']['allStarships']['edges']

  end



  def show
    id_starship = params[:id]
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
