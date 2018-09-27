class Car
  attr_accessor :id, :make, :modelName, :year

  def self.open_connection
    conn = PG.connect(dbname: "cars")
  end

  def save
    conn = Car.open_connection

    if !self.id
      sql = "INSERT INTO cars (make, modelName, year) VALUES ('#{self.make}', '#{self.modelName}', '#{self.year}')"
    else
      sql = "UPDATE cars SET make = '#{self.make}', modelName = '#{self.modelName}', year = '#{self.year}' WHERE id='#{self.id}'"
    end

    conn.exec(sql)
  end

  def self.all
    conn = self.open_connection
    sql = "SELECT * FROM cars ORDER BY id"
    result = conn.exec(sql)

    cars = result.map do |car|
      self.hydrate car
    end

    cars
  end

  def self.find id
    conn = self.open_connection
    sql = "SELECT * FROM cars WHERE id=#{id}"
    results = conn.exec(sql)

    car = self.hydrate results[0]

    car
  end

  def self.destroy id
    conn = self.open_connection
    sql = "DELETE FROM cars WHERE id=#{id}"
    conn.exec(sql)
  end

  def self.hydrate car_data
    car = Car.new

    car.id = car_data['id']
    car.make = car_data['make']
    car.modelName = car_data['modelName']
    car.year = car_data['year']

    car
  end

end
