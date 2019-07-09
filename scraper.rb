require 'nokogiri'
require 'open-uri'

puts "What ingredient would you like a recipe for?"
ingredient = gets.chomp

url = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{ingredient}"

raw_html = open(url).read
doc = Nokogiri::HTML(raw_html)


doc.search('.m_contenu_resultat').first(5).each do |element|
  p element.search('.m_titre_resultat a').text.strip
  p element.search('.m_texte_resultat').text.strip
  puts
end




# doc.search('.m_titre_resultat a').first(5).each do |element|
#   puts element.text.strip
# end

# puts

# doc.search('.m_texte_resultat').first(5).each do |element|
#   puts element.text.strip
# end
