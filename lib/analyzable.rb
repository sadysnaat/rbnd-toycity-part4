module Analyzable
  # Your code goes here!
  def average_price(products)
    total = 0.0
    products.each do |product|
      total += product.price.to_f
    end
    return (total / products.size).round(2)
  end

  def print_report(products)
    brand_counts = count_by_brand(products)
    name_counts = count_by_name(products)
    puts "Inventory by Brand"
    brand_counts.each_pair do |key, value|
      puts "\t- #{key}: #{value}"
    end
    puts "Inventory by Name"
    name_counts.each_pair do |key, value|
      puts "\t- #{key}: #{value}"
    end
    return average_price(products).to_s
  end

  def method_missing(method_name, *args, &block)
    if method_name.to_s.start_with?('count_by_')
      count_by = method_name.to_s.sub('count_by_','')
      count(items: args[0], by: count_by)
    else
      super
    end
  end

  def respond_to_missing(method_name, include_private = false)
    method_name.to_s.start_with?('count_by_') || super
  end

  private
    def count(opts={})
      items = opts[:items]
      by = opts[:by].to_sym
      count_hash = {}
      items.each do |item|
        if count_hash.key? item.send(by)
          count_hash[item.send(by)] += 1
        else
          count_hash[item.send(by)] = 1
        end
      end
      return count_hash
    end
end
