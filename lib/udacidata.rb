require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  # Your code goes here!
  def self.create(opts={})
    new_object = self.new(opts)
    if not self.all.include? new_object
      CSV.open(self::FILE_PATH, 'ab') do |csv|
        csv << new_object.to_csv_array
      end
    end
    return new_object
  end

  def self.all(opts={})
    result = []
    CSV.read(self::FILE_PATH, headers: true).each do |row|
      object_hash = row.to_hash
      # Code taken from
      # http://stackoverflow.com/questions/800122/best-way-to-convert-strings-to-symbols-in-hash
      object_hash = object_hash.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

      # This has to be done as test case call product name as product
      object_hash[:name] = object_hash[:product]

      result << self.new(object_hash)
    end
    return result
  end

  def self.first(n=1)
    result =  self.all.first(n)
    if result.size == 1
      return result[0]
    else
      return result
    end
  end

  def self.last(n=1)
    result = self.all.last(n)
    if result.size == 1
      return result[0]
    else
      return result
    end
  end

  def self.find(id)
    self.all.each do |item|
      if item.id == id
        return item
      end
    end
    raise ProductNotFoundError, "No Product with id #{id} found."
  end

  def self.where(opts={})
    result = []
    # TODO: Add support for multiple search for criterias
    search_for = opts.keys[0]
    search_value = opts[search_for]
    self.all.each do |item|
      if item.send(search_for) == search_value
        result << item
      end
    end
    return result
  end

  def self.destroy(id)
    item_to_destroy = self.find(id)
    items_to_keep = []
    self.all.each do |item|
      if item.id != id
        items_to_keep << item
      end
    end
    CSV.open(self::FILE_PATH, 'wb') do |csv|
      csv << self.to_csv_headers
      items_to_keep.each do |item|
        csv << item.to_csv_array
      end
    end
    return item_to_destroy
  end
end
