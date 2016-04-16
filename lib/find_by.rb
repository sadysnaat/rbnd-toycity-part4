class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
    attributes.each do |attribute|
      self.class_eval %{def self.find_by_#{attribute} (value)
        self.all.each do |item|
          if item.#{attribute} == value
            return item
          end
        end
        raise ProductNotFoundError, "No Product with #{attribute} "+ value +" found."
      end}
    end
  end
end
