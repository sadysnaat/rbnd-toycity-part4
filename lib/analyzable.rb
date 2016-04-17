module Analyzable
  # Your code goes here!
  def average_price(items)
    total = 0.0
    items.each do |item|
      total += item.price.to_f
    end
    return (total / items.size).round(2)
  end

  def print_report(items)
    # Get the class of objects being analyzed
    # This generalization will help when we will
    # have multiple Classes
    class_analyzed = items[0].class
    class_analyzed.queryable.each do |query|
      counts = self.send("count_by_#{query}".to_sym, items)
      self.send("inventory_by_#{query}".to_sym, counts)
    end
    return average_price(items).to_s
  end

  def method_missing(method_name, *args, &block)
    if method_name.to_s.start_with?('count_by_')
      by = method_name.to_s.sub('count_by_','')
      count(items: args[0], by: by)
    elsif method_name.to_s.start_with?('inventory_by_')
      by = method_name.to_s.sub('inventory_by_','')
      inventory(counts: args[0], by: by)
    else
      super
    end
  end

  def respond_to_missing(method_name, include_private = false)
    method_name.to_s.start_with?('count_by_') ||
    method_name.to_s.start_with?('inventory_by_') ||
    super
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

    def inventory(opts={})
      counts = opts[:counts]
      by = opts[:by]
      puts "Inventory by #{by.capitalize}".light_red
      counts.each_pair do |key, value|
        puts "  - #{key}".light_blue + ":".light_yellow + "#{value}".green
      end
    end
end
