class PlanetController < ApplicationController

    def index
        query = 'query {allPlanets {edges {node {id name}}}}'
        respuesta = RestClient.get "https://swapi-graphql-integracion-t3.herokuapp.com/", {params: {'query' => query}}
        respuesta = JSON.parse(respuesta)
        all_planets = respuesta['data']['allPlanets']['edges']
        @planets = all_planets
        
    end


    def show
        id_planet = params[:id]
        query = 'query {allPlanets {edges {node {id name rotationPeriod orbitalPeriod diameter climates gravity terrains surfaceWater population residentConnection{edges {node {id name}}} filmConnection{edges {node {title id}}}}}}}'
        respuesta = RestClient.get "https://swapi-graphql-integracion-t3.herokuapp.com/", {params: {'query' => query}}
        respuesta = JSON.parse(respuesta)
        all_planets = respuesta['data']['allPlanets']['edges']
        # puts all_vehicles
        founded = nil
        all_planets.each do |planet|
            if planet['node']['id'] == id_planet
                founded = planet['node']
                break
            end
        end
        @general = founded
    end

end
