class App < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  # Setting the root as the parent directory of the current directory
  set :root, File.join(File.dirname(__FILE__), "..")

  # Sets the view directory correctly
  set :views, Proc.new {File.join(root, "views")}

  # INDEX
  get "/cars" do
    @title = "Index Page"
    @cars = Car.all
    puts @cars.class

    erb :"cars/index" # links to the index.erb page
  end

  # NEW
  get "/cars/new" do
    erb :"cars/new" # links to the new.erb page
  end

  # SHOW
  get "/cars/:id" do
    id = params[:id].to_i
    @car = Car.find id

    erb :"cars/show" # links to the show.erb page
  end

  # CREATE
  post "/cars" do

    car = Car.new

    car.make = params[:make]
    car.modelname = params[:modelname]
    car.year = params[:year]

    car.save

    redirect "/cars"
  end

  # UPDATE
  put "/cars/:id" do
    id = params[:id].to_i

    car = Car.find id
    # changing the car info to user inputs
    car.make = params[:make]
    car.modelname = params[:modelname]
    car.year = params[:year]

    car.save
    # going back to the index page
    redirect "/cars"
  end

  # DELETE
  delete "/cars/:id" do
    id = params[:id].to_i
    # deleting the car
    Car.destroy id
    # going back to the index page
    redirect "/cars"
  end

  # EDIT
  get "/cars/:id/edit" do
    id = params[:id].to_i
    @car = Car.find id

    erb :"cars/edit" # links to the edit.erb page
  end

end
