require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
    redirect "/recipes"
  end 

  get '/recipes' do 
    @recipes = Recipe.all
    erb :index
  end 

  post '/recipes' do 
    @new_recipe = Recipe.new(params)
    @new_recipe.save
    redirect "/recipes/#{@new_recipe.id}"
  end 

  get '/recipes/new' do 
    erb :new
  end 

  get '/recipes/:id' do 
    @recipe = Recipe.find(params[:id])
    erb :show
  end 

  get '/recipes/:id/edit' do 
    @recipe = Recipe.find(params[:id])
    erb :edit
  end 

  patch '/recipes/:id' do 
    @recipe = Recipe.find(params[:id])
    @recipe.update(name: params["name"], ingredients: params["ingredients"], cook_time: params["cook_time"])
    redirect "/recipes/#{@recipe.id}"
  end 

  delete '/recipes/:id' do 
    Recipe.delete(params[:id])
    redirect '/recipes'
  end 
end 
