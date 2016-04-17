require_relative 'udacidata'

class Product < Udacidata
  attr_reader :id, :price, :brand, :name

  # FILE_PATH can be use to store file location
  # for class. Each class can have their own file path
  FILE_PATH = File.dirname(__FILE__) + "/../data/data.csv"
  create_finder_methods("brand", "name")

  def initialize(opts={})

    # Get last ID from the database if ID exists
    get_last_id
    # Set the ID if it was passed in, otherwise use last existing ID
    @id = opts[:id] ? opts[:id].to_i : @@count_class_instances
    # Increment ID by 1
    auto_increment if !opts[:id]
    # Set the brand, name, and price normally
    @brand = opts[:brand]
    @name = opts[:name]
    @price = opts[:price]
  end

  # Classes Inheriting from Udacidata should
  # implement these functions
  # These methods help while writing to CSV
  def to_csv_array
    return [id, brand, name, price]
  end

  def self.to_csv_headers
    return ["id", "brand", "product", "price"]
  end

  def ==(another_product)
    id == another_product.id
  end

  private

    # Reads the last line of the data file, and gets the id if one exists
    # If it exists, increment and use this value
    # Otherwise, use 0 as starting ID number
    def get_last_id
      file = File.dirname(__FILE__) + "/../data/data.csv"
      last_id = File.exist?(file) ? CSV.read(file).last[0].to_i + 1 : nil
      @@count_class_instances = last_id || 0
    end

    def auto_increment
      @@count_class_instances += 1
    end

end
