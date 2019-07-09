require_relative 'view'
require_relative 'recipe'
require 'pry-byebug'
require 'nokogiri'
require 'open-uri'

class Controller
  def initialize(cookbook)
    @view = View.new
    @cookbook = cookbook
  end

  def list
    recipes = @cookbook.all
    @view.display_recipes(recipes)
  end

  def create
    new_recipe = Recipe.new(
      name: @view.ask_for_name,
      description: @view.ask_for_description
    )
    @cookbook.add_recipe(new_recipe)
  end

  def destroy
    list
    index = @view.ask_for_index
    @cookbook.remove_recipe(index)
  end

  def import
    # ask the user which ingredient to scrape = @view
    ingredient = @view.ask_for_ingredient
    # pass the ingredient to the url
    url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{ingredient}"

    raw_html = open(url).read
    doc = Nokogiri::HTML(raw_html)

    scraped_recipes = []
    # retrieve the top 5 from that url
    doc.search('.m_contenu_resultat').first(5).each do |element|
      title = element.search('.m_titre_resultat a').text.strip
      description = element.search('.m_texte_resultat').text.strip

      # binding.pry if title == "Banana flambé"

      # prep_time = element.search('.m_detail_time div').first.nil? ? element.search('.m_detail_time div').first.text.strip : ''

      unless element.search('.m_detail_time div').first.nil?
        prep_time = element.search('.m_detail_time div').first.text.strip
      else
        prep_time = ''
      end

      # take a look at the structure of let's cook french
      # this is the text after scraping this css selector
      # "Recipe - Main course - Easy - Moderate"
      # we just need to get the third word => "Easy"
      difficulty = element.search('.m_detail_recette').text.strip.split(' - ')[2]

      # create new recipe instance
      scraped_recipes << Recipe.new(
        name: title,
        description: description,
        prep_time: prep_time,
        difficulty: difficulty
      )
    end

    @view.display_recipes(scraped_recipes)
    # ask the user again which index of the recipe u want to store to ??
    imported_recipe_index = @view.ask_for_index
    imported_recipe = scraped_recipes[imported_recipe_index]

    # store back to the cookbook
    @cookbook.add_recipe(imported_recipe)
  end

  def mark
    list
    index = @view.which_to_mark
    marked_recipe = @cookbook.find(index)

    @cookbook.mark_as_done(marked_recipe)
  end
end














