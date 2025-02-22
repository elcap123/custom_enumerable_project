module Enumerable
  # Your code goes here
  def my_each_with_index
    index = 0
    self.my_each do |item|
      yield(item, index)
      index += 1
    end
  end

  def my_select
    filtered_array = []
    self.my_each do |item|
      if yield(item)
        filtered_array << item
      end
    end
    filtered_array
  end

  def my_all?
    self.my_each do |item|
      return false unless yield(item)
    end
    true
  end

  def my_any?
    self.my_each do |item|
      return true if yield(item)
    end
    false
  end

  def my_none?
    self.my_each do |item|
      return false if yield(item)
    end
    true
  end

  def my_count
    if block_given?
      count = 0
      self.my_each do |item|
        if yield(item)
          count += 1
        end
      end
      count
    else
      self.length
    end
  end

  def my_map
    new_array = []
    self.my_each do |item|
      new_array << yield(item)
    end
    new_array
  end

  def my_inject(input)
    self.my_each do |item|
      input = yield(input, item)
    end
    input
  end

end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    if block_given?
      for item in self
        yield(item)
      end
    end
  end
end
