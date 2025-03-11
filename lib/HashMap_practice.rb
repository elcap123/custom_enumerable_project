# require_relative 'linked_list_practice'
# above doesn't work for rdbg well

class LinkedList
  # represents the full list.
  # Is it just an array of nodes?
  attr_accessor :list
  
  def initialize()
    self.list = Array.new()
  end

  def append(key, value)
    # adds a new node containing value to the end of the list
    list.push(Node.new(key, value, nil))
    # update next_node value
    if list.length > 1
      list[list.length-2].next_node = list.length - 1
    end
    
  end

  def set(key, value)
    # updates an existing node, or appends a new one
    if contains_key(key)
      # TODO: update key value
      debugger
      # we don't need to update the next node pointer in this scenario
    else
      append(key,value)
    end
  end

  def prepend(key, value)
    # adds a new node containing the value to the start of the list
    list.unshift(Node.new(key, value, 1))
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

  def find_key_index(key)
    # checks the list for a given key, returns the key index if found.
    # otherwise returns nil.
    list.each_with_index do |node, index|
      # node.value should return a hash.
      if node.key == key
        return index
      end
    end
    nil
  end

  def get_value_for_key(key)
    # if the given key matches a node's key, returns the first value. Else nil.
    list.each do |node|
      if node.key == key
        return node.value
      end
    end
    nil
  end

  def contains_key?(key)
    list.each do |node|
      if node.key == key
        return true
      end
    end
    false
  end

  def remove(key)
    # removes a node with the specified key, and returns the value.
    node_index = find_key_index(key)
    debugger
    list.delete_at(node_index)
  end

  def to_s
    value_array = list.map do |node|
      node.value
    end
    value_array.push(nil)
    value_array.join(' -> ')
  end

  def get_keys
    if list.empty?
      nil
    else
      key_array = []
      list.each do |node|
        key_array << node.key
      end

      key_array.compact
    end
  end

  def values
    if list.empty?
      nil
    else
      value_array = []
      list.each do |node|
        value_array << node.value
      end
      value_array # don't use compact since value might be nil.
    end
  end
end



class Node
  attr_accessor :key, :value, :next_node

  def initialize(key, value, next_node)
    self.key = key
    self.value = value
    self.next_node = nil
  end
end


class HashMap
  attr_accessor :load_factor, :capacity, :buckets

  def initialize
    
    self.capacity = 16
    self.buckets = Array.new(capacity) { LinkedList.new() }
    self.load_factor = 0.75
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
       
    # will I eventually need to update this to account for my HashMap capacity?
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
       
    hash_code
  end


  def get_bucket_id(key)
    hash_code = hash(key)
    hash_code % capacity
  end
  
  def set(key, value)
    # if a key already exists, then the old val is overwritten
    bucket_to_use = get_bucket_id(key)
    buckets[bucket_to_use].append(key, value)
    
    double_capacity if overloaded?
  end

  def get(key)
    bucket_to_use = get_bucket_id(key)
    buckets_list = buckets[bucket_to_use]
    buckets_list.get_value_for_key(key)
  end

  def has?(key)
    bucket_to_use = get_bucket_id(key)
    buckets[bucket_to_use].contains_key?(key)
  end

  def remove(key)
    # if the key exists, remove the node and return the node's value.
    # Else nil.
    if has?(key)
      # we know it exists
      linked_list = buckets[get_bucket_id(key)]
      debugger
      return linked_list.remove(key)
    end
    nil
  end

  def double_capacity
    self.capacity = self.capacity * 2
    old_buckets = buckets
    self.buckets = Array.new(capacity) { LinkedList.new() }

    # Re-map the old hashes
    old_buckets.each do |bucket|
      if bucket.list.empty?
        next
      else
        # for each node's key, re-add it to the new buckets
        bucket.list.each do |node|
          set(node.key, node.value)
        end
      end
    end
  end

  def length
    # returns # of stored keys in the hash map
    buckets.reduce(0) do |count, bucket|
      if bucket.list.empty?
        count
      else
        count + bucket.list.length
      end
    end
  end

  def clear
    # removes all entries in the hash map
    self.capacity = 16
    self.buckets = Array.new(capacity) { LinkedList.new() }
  end

  def get_keys
    # returns all keys in the hash map
    all_keys = buckets.map do |bucket|
      if bucket.list.empty?
        nil
      else
        bucket.get_keys
      end
    end
    all_keys.compact.flatten # ok to remove nils since there would be zero nil keys
  end

  def values
    # returns all keys in the hash map
    all_values = buckets.map do |bucket|
      if bucket.list.empty?
        nil
      else
        bucket.values
      end
    end
    all_values
  end

  def entries
    debugger
    all_keys = get_keys
    output = []
    all_keys.map do |key|
      output << [key, get(key)]
    end
    output
  end

  def overloaded?
    length > (capacity * load_factor)
  end

end

test = HashMap.new()
 test.set('apple', 'red')
 test.set('banana', 'yellow')
 test.set('carrot', 'orange')
 test.set('dog', 'brown')
 test.set('elephant', 'gray')
 test.set('frog', 'green')
 test.set('grape', 'purple')
 test.set('hat', 'black')
 test.set('ice cream', 'white')
 test.set('jacket', 'blue')
 test.set('kite', 'pink')
 test.set('lion', 'golden')

test.length
test.set('dog', 'tuxedo')
test.length