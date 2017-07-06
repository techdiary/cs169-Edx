# When done, submit this entire file to the autograder.

# Part 1

def sum arr
  sum = 0
  arr.each {|x| sum+=x}
  return sum
end

def max_2_sum arr
 new_arr = arr.sort.reverse
  if arr.empty?
   return 0
    else
      return new_arr[0].to_i + new_arr[1].to_i
  end
end

def sum_to_n? arr, n
  return false if arr.length == 0 || arr.length == 1
  #comb_arr = arr.combination(2).to_a
  answer =  arr.combination(2).to_a.each { |arr| break true if arr.sum == n }
  if answer == true
    p true
  else
    p false
  end
end

# Part 2

def hello(name)
  p "Hello, " + name
end

def starts_with_consonant? s
 s.downcase!
 if /[bcdfghjklmnpqrstvwz]/.match(s[0])
    p true
 else
    p false
 end
end

def binary_multiple_of_4? s
  # takes a string and returns true if the string represents a binary number that is a multiple of 4.
  return true if s == 0.to_s
  if s.to_i(2) == 0
    return false
  elsif s.to_i(2) % 4 == 0
    return true
  else
    return false
  end
end

# Part 3

class BookInStock
  attr_accessor :isbn
  attr_accessor :price

  @isbn = ''
  @price = 0.0

  def initialize isbn, price
    raise ArgumentError if isbn.strip.empty? || price <= 0
    @isbn = isbn
    @price = price
  end

  def price_as_string
    #returns the price of the book formatted with a leading dollar sign and two decimal places
    decorated_price = "$%.2f" % @price
    p decorated_price
  end

end
