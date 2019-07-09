class Recipe
  attr_reader :name, :description, :prep_time, :difficulty
  attr_accessor :status
  # Defining my model with 2 attibutes: name and description

  def initialize(attributes)
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time]
    @status = attributes[:status] || false
    @difficulty = attributes[:difficulty] || nil
  end
end
