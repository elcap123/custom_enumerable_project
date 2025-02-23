class LinkedList
  # represents the full list.
  # Is it just an array of nodes?
  attr_accessor :list
  
  def initialize
    self.list = []
  end

  def append(value)
    # adds a new node containing value to the end of the list
    list.push(Node.new(value, nil))
    list[list.length-2].next_node = list.length - 1
  end

  def prepend(value)
    # adds a new node containing the value to the start of the list
    list.unshift(Node.new(value, 1))
  end

  def size
    list.length
  end

  def head
    list[0]
  end

  def tail
    list[-1]
  end

  def at(index)
    list.dig(index)
  end

  def pop
    # remove last element
    removed_element = list.pop
    # nil out the new last element's next_node
    list[-1].next_node = nil
    removed_element
  end

  def contains?(value)
    list.each do |node|
      if node.value == value
        return true
      end
    end
    false
  end

  def find(value)
    list.each_with_index do |node, index|
      if node.value == value
        return index
      end
    end
    nil
  end

  def to_s
    value_array = list.map do |node|
      node.value
    end
    value_array.push(nil)
    value_array.join(' -> ')
  end
end

class Node
  attr_accessor :value, :next_node

  def initialize(value, next_node)
    self.value = value
    self.next_node = nil
  end
end

list = LinkedList.new

list.append('dog')
list.append('cat')
list.append('parrot')
list.append('hamster')
list.append('snake')
list.append('turtle')

puts list