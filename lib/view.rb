class View
  def display_recipes(recipes_array)
    recipes_array.each_with_index do |recipe, index|
      puts "#{index + 1} - #{recipe.name}"
      puts "Description: #{recipe.description}"
      puts "---------------------------------"
    end
  end

  def ask_for_name
    puts "Insert the name"
    return gets.chomp
  end

  def ask_for_description
    puts "Insert the description"
    return gets.chomp
  end

  def ask_for_index
    puts "Insert the index"
    return gets.chomp.to_i - 1
  end
end
