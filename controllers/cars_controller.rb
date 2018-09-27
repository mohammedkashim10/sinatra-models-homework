class App < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  # Setting the root as the parent directory of the current directory
  set :root, File.join(File.dirname(__FILE__), "..")

  # Sets the view directory correctly
  set :views, Proc.new {File.join(root, "views")}

  # making array for cars
  $cars = [
    {
      :id => 1,
      :make => "Audi",
      :model => "R8",
      :year => 2006
    },
    {
      :id => 2,
      :make => "Nissan",
      :model => "GTR",
      :year => 2007
    },
    {
      :id => 3,
      :make => "Ferrari",
      :model => "458",
      :year => 2009
    },
    {
      :id => 4,
      :make => "Pagani",
      :model => "Zonda",
      :year => 1999
    }
  ]

  # INDEX
  get "/cars" do
    @title = "Index Page"
    @cars = $cars

    erb :"cars/index" # links to the index.erb page
  end

  # NEW
  get "/cars/new" do
    erb :"cars/new" # links to the new.erb page
  end

  # SHOW
  get "/cars/:id" do
    id = params[:id].to_i
    @car = $cars[id - 1] # array is zero index hence -1

    erb :"cars/show" # links to the show.erb page
  end

  # CREATE
  post "/cars" do
    id = $cars.length + 1
    # creating a new car
    newCar = {
      :id => id,
      :make => params[:make],
      :model => params[:model],
      :year => params[:year]
    }
    # adding car to the cars array
    $cars.push newCar
    # going back to the index page
    redirect "/cars"

    puts $cars
  end

  # UPDATE
  put "/cars/:id" do
    id = params[:id].to_i - 1
    @car = $cars[id]

    car = $cars[id]
    # changing the car info to user inputs
    car[:make] = params[:make]
    car[:model] = params[:model]
    car[:year] = params[:year]

    $cars[id] = car
    # going back to the index page
    redirect "/cars"
  end

  # DELETE
  delete "/cars/:id" do
    id = params[:id].to_i - 1
    # deleting the car
    $cars.delete_at id
    # going back to the index page
    redirect "/cars"
  end

  # EDIT
  get "/cars/:id/edit" do
    id = params[:id].to_i - 1
    @car = $cars[id]

    erb :"cars/edit" # links to the edit.erb page
  end

end
