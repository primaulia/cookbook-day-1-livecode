require "pry-byebug"
require 'csv'

class Cookbook
  def initialize(csv_file)
    @csv_file = csv_file
    @recipes = []
    load_csv
  end

  def all
    return @recipes
  end

  def find(index)
    @recipes[index]
  end

  def add_recipe(recipe)
    @recipes << recipe
    write_to_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    write_to_csv
  end

  def mark_as_done(marked_recipe)
    marked_recipe.status = true
    write_to_csv
  end

  def write_to_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      csv << ['name', 'description', 'prep_time', 'status']
      @recipes.each do |recipe|
        name = recipe.name
        description = recipe.description
        prep_time = recipe.prep_time
        status = recipe.status

        csv << [name, description, prep_time, status]
      end
    end
  end

  def load_csv
    csv_options = { col_sep: ',', quote_char: '"', headers: true, header_converters: :symbol }

    CSV.foreach(@csv_file, csv_options) do |recipe|
      new_recipe = Recipe.new(recipe)
      new_recipe.status = recipe[:status] == 'true'
      # binding.pry
      @recipes << new_recipe
    end
  end
end







