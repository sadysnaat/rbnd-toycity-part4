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
      result << self.new(object_hash)
    end
    return result
  end
end
