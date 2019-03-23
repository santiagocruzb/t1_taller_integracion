require 'rest-client'

class StaticPagesController < ApplicationController
  def home
    @response = RestClient.get "https://swapi.co/api"
    # response = RestClient.get "https://swapi.co/api", '{"name": "NEW_NAME12323","iso_639_1": "en"}', {content_type: "application/json;charset=utf-8", authorization: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYmYiOjE1MTk4NDYyNzYsInN1YiI6IjVhOGNhNDBmOTI1MTQxMGIwMTA4ZjUzNiIsImp0aSI6IjY5OTkxOCIsImF1ZCI6IjEyMDgyMWY2ZDIxOTE4Y2Y1NzA1MGNmOWU4Y2Q0ZDBhIiwic2NvcGVzIjpbImFwaV9yZWFkIiwiYXBpX3dyaXRlIl0sInZlcnNpb24iOjF9.4B-StWrStNmjIUI7f4BBKej4dGJCIW6oK3lR-W-5o8A"}
    puts response.code
  end

  def help
  end
end
