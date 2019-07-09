class View
  def display_recipes(recipes_array)
    recipes_array.each_with_index do |recipe, index|
      puts "#{index + 1}. [#{recipe.status ? "X" : " "}] #{recipe.name} #{recipe.difficulty.nil? ? '' : '- ' + recipe.difficulty} (#{ recipe.prep_time.nil? ? '' : recipe.prep_time})"
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

  def which_to_mark
    puts "Which one should i mark as done?"
    return gets.chomp.to_i - 1
  end

  def ask_for_ingredient
    puts "What ingredient would you like a recipe for?"
    return gets.chomp
  end
end
