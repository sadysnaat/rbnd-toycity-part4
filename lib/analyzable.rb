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
    brand_counts = {}
    name_counts = {}
    products.each do |product|
      brand = product.brand.to_sym
      name = product.name.to_sym
      if brand_counts.key? brand
        brand_counts[brand] += 1
      else
        brand_counts[brand] = 1
      end
      if name_counts.key? name
        name_counts[name] += 1
      else
        name_counts[name] = 1
      end
    end
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

  def count_by_brand(products)
    if products.size == 0
      return {}
    end
    return {products[0].brand => products.size }
  end

  def count_by_name(products)
    if products.size == 0
      return {}
    end
    return {products[0].name => products.size}
  end
end
