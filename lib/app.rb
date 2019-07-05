require_relative 'cookbook'
require_relative 'controller'
require_relative 'router'

# defining the csv file I want to use
csv_file   = File.join(__dir__, 'recipes.csv')
# Instanciate a cookbook connect the file to my cookbook (repository)
cookbook   = Cookbook.new(csv_file)
# nstanciate a controller with the cookbook
controller = Controller.new(cookbook)
# passing the controller to the router. The router is connectect to the controller, that is connected to the view,
# to the repository (cookbook) and
# to the model Recipe (require_relative "recipe" on line 2 of the controller)
router = Router.new(controller)

# Start the app
router.run
