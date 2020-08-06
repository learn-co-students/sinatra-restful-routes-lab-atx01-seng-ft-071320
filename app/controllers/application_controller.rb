# class ApplicationController < Sinatra::Base
#   configure do
#     set :public_folder, 'public'
#     set :views, 'app/views'
#   end
#   # code actions here!
#   #This Route/action: shows all recipes
#   get '/recipes' do 
#     @recipes = Recipe.all
#     erb :index
#   end
  
#   #This Route/action: displays a form for new recipe
#   get '/recipes/new' do
#     erb :new
#   end
  
#   #This Route/action: displays a specific recipe
#   get '/recipes/:id' do
#     @recipe = Recipe.find(params[:id])
#     erb :show
#   end
  
#    #This Route/action: creates a new recipe
#   post '/recipes' do
#     @recipe = Recipe.new
#     @recipe.name = params[:name]
#     @recipe.ingredients = params[:ingred]
#     @recipe.cook_time = params[:ct]
#     @recipe.save
#     redirect to '/recipes/#{@recipe.id}'
#   end
  
#   #This Route/action: displays a form to edit existing recipe
#   get '/recipes/:id/edit' do
#     @recipe = Recipe.find(params[:id])
#     erb :edit
#   end
  
#   #This Route/action: returns newly updated recipe
#   patch '/recipes/:id' do
#     @recipe = Recipe.find(params[:id])
#     @recipe.update(name: params[:name], ingredients: params[:ingred], cook_time: params[:cooking_time]  )
#     @recipe.save
#     redirect to '/recipes/#{@recipe.id}'
#   end
  
#   #This Route/action: deletes a recipe and returns user a list of all  existing recipes
#   delete '/recipes/:id' do
#     @recipe = Recipe.find(params[:id])
#     @recipe.destroy 
#     redirect to '/recipes'
#   end

  

# end


require './config/environment'

class ApplicationController < Sinatra::Base
  # register Sinatra::ActiveRecordExtension
  

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes/new' do #loads new form
    erb :new
  end

  get '/recipes' do #loads index page
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/:id' do  #loads show page
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do #loads edit form
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do  #updates a recipe
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.update(name: params[:name], ingredients: params[:ingred], cook_time: params[:cooking_time]  )
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  post '/recipes' do  #creates a recipe
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do #destroy action
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end

end