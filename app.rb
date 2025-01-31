require "sinatra"
require "sinatra/reloader"
require 'net/http'
require 'json'




def getRecipe(search_term)
  api_key = ENV.fetch("API_KEY")
  api_id = ENV.fetch("API_ID")
  url = URI("https://api.edamam.com/api/recipes/v2?type=public&q=#{search_term}&app_id=#{api_id}&app_key=#{api_key}")
  response = Net::HTTP.get(url)
  response_obj = JSON.parse(response)
  results = response_obj.fetch("hits")
end


get("/") do

  erb(:home)
end

post("/recipe_search") do
  
  search_term = params.fetch("search_term")
  @results = getRecipe(search_term)

  erb(:recipe)
end
