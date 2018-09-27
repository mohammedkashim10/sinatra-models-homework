require "sinatra"
require "sinatra/contrib"
require "sinatra/reloader" if development?
require "pg"
require_relative "./models/car.rb"
require_relative "./controllers/cars_controller.rb"

use Rack::Reloader
use Rack::MethodOverride

run App
