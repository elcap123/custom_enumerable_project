

def palindrome?(word)
  letter_array = word.split('')
  
  if letter_array.length <= 1
    return true
  elsif letter_array.pop == letter_array.shift
    return palindrome?(letter_array.join)
  else
    return false
  end

end

tests = ['hello', 'racecar', 'a', 'wow', 'cow', 'awola']
tests.each {|word| puts palindrome?(word) }

def beer(n)
  n = n.to_i
  
  if n <= 0
    puts 'no more bottles of beer on the wall'
  else
    puts "#{n} bottles of beer on the wall"
    beer(n-1)
  end
end

beer(5)

def fibonacci(n)
  if n == 1
    1
  elsif n == 0
    0
  else 
    fibonacci(n-2) + fibonacci(n-1)
  end
end

puts fibonacci(5)



def merge_sort(array)
  if array.length <= 1
    return array
  end
  # split the arrays
  midpoint = array.length / 2
  first_half = merge_sort(array[0..midpoint - 1])
  second_half = merge_sort(array[midpoint.. -1])
  # debugger
  # join the arrays. Is this part breaking the recursion challenge?
  new_array = []
  for i in 0..array.length-1
    if first_half[0].nil?
      new_array[i] = second_half.shift
    elsif second_half[0].nil?
      new_array[i] = first_half.shift
    elsif first_half[0] <= second_half[0]
      new_array[i] = first_half.shift
    elsif second_half[0] < first_half[0]
      new_array[i] = second_half.shift
    else
      new_array[i] = 'error'
    end
  end
  new_array
end


puts 'starting merge_sort'
input = [3, 2, 1, 13, 8, 5, 0, 1]
output = merge_sort(input)
puts output