module Analyzable
  # Your code goes here!
  def average_price(products)
    total = 0.0
    products.each do |product|
      total += product.price.to_f
    end
    return (total / products.size).round(2)
  end
end
