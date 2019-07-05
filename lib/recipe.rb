class Recipe
  attr_reader :name, :description
  # Defining my model with 2 attibutes: name and description
  def initialize(name, description)
    @name = name
    @description = description
  end
end
