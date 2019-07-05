require "pry-byebug"
require 'csv'

class Cookbook
  def initialize(csv_file)
    # store the path of the csv file in a variable
    @csv_file = csv_file
    # initialize an empty array that will contain all the recipes
    @recipes = []
    # load the data from csv
    load_csv
  end

  def all
    # get all the recipes
    return @recipes
  end

  def add_recipe(recipe)
    # push a recipe into the array of recipes
    @recipes << recipe
    # re-write the csv file (call the method defined on line 34)
    # as soon as the array is updated, I rewrite the csv file with the last "version" of the array
    write_to_csv
  end

  def remove_recipe(index)
    # remove the emelment with index "index" from the array of recipes
    @recipes.delete_at(index)
    # re-write the csv file
    # as soon as the array is updated, I rewrite the csv file with the last "version" of the array
    write_to_csv
  end

  def write_to_csv
    # set the csv options -> No Header
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    # open the csv file. I'm ready to write on it
    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      # I don't add any header (The rake doesn't require it. During the livecode I added it, but I removed)
      # Iterate on the array of recipes
      @recipes.each do |recipe|
        #  Save the name of the recipe in a variable
        name = recipe.name
        # Store the description of the recipe in a variable
        description = recipe.description
        # Write a new line in my csv file (Pushing an array that looks like ["Pasta", "Pasta description"])
        csv << [name, description]
      end
      # At the end of the loop, close the csv file
    end
    # Close the method write_to_csv
  end

  def load_csv
    # set the csv options -> No Header
    csv_options = { col_sep: ',', quote_char: '"' }
    # Open the csv. I start to iterate line by line (row by row)
    CSV.foreach(@csv_file, csv_options) do |row|
      # Since we don't have headers, the row will be similar to:
      # ["Pasta", "Pasta description"]. Store the first element (name) in the variable name
      name = row[0]
      # Store the element at row[1] as description
      description = row[1]
      # I have a name and a description. I'm able to create a new instance of Recipe
      recipe = Recipe.new(name, description)
      # Push the instance in the array of recipes
      @recipes << recipe
    end
    # out of the csv loop. Closing the method
  end
end







