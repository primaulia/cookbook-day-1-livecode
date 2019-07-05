require_relative "view"
require_relative "recipe"
require "pry-byebug"

class Controller
  def initialize(cookbook)
    # create the connection with the view file. At this point the controller is able to comunicate with the view
    @view = View.new
    # adding the repository in the controller.
    # At this point the controller is able to comunicate with the repository
    @cookbook = cookbook
  end

  def list
    # Ask to the repository all the recipes. The method @cookbok.all gives back an array
    recipes = @cookbook.all
    # display the recipes. Call the method display_recipes in my view and pass recipes as parameters
    @view.display_recipes(recipes)
  end

  def create
    # ask the user for the name
    name = @view.ask_for_name
    # ask the user for the description
    description = @view.ask_for_description
    # create a recipe with the info the user just insert
    new_recipe = Recipe.new(name, description)
    # push the new recipe into the repository
    @cookbook.add_recipe(new_recipe)
  end

  def destroy
    # list all the recipes. So the user can choose.
    list
    # ask an index to the user
    index = @view.ask_for_index
    # update the repository removing the recipe with index index
    @cookbook.remove_recipe(index)
  end
end
