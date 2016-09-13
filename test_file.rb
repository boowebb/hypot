require 'byebug'

# seed test file
def test_to(upper_bound)
  true_arr = [] # load array with results that we know work
  max_sum  = upper_bound ** 2 * 2

  # load array - it's possible that integers above upper bound will produce
  # results so must build results beyond this for testing to fill in the gaps
  # EG 12^2 * 2 == 288 but 13^2+1^2 = 173
  (1..Math.sqrt(max_sum).ceil).each do |idx|
    (1..idx).each do |jdx|
      result = idx**2+jdx**2

     # puts "#{idx} | #{ jdx } : #{ result }"

      true_arr << result
    end
  end

  puts "RUNNING TEST 1 (1..#{ true_arr.max })"
  run_test(true_arr, max_sum, "sum_of_squares_1?")     # tests aggressive loop

  puts "RUNNING TEST 2 (1..#{ true_arr.max })"
  run_test(true_arr, max_sum, "sum_of_squares_2?")     # tests typical ruby enumeration

  puts "RUNNING TEST 3 (1..#{ true_arr.max })"
  run_test(true_arr, max_sum, "sum_of_squares_3?")     # tests integer UPTO (both loops)

  puts "RUNNING TEST 4 (1..#{ true_arr.max })"
  run_test(true_arr, max_sum, "sum_of_squares_4?")     # tests integer DOWNTO (both loops)

  puts "RUNNING TEST 5 (1..#{ true_arr.max })"
  run_test(true_arr, max_sum, "sum_of_squares_5?")     # tests UPTO / DOWNTO

  puts "RUNNING TEST 6 (1..#{ true_arr.max })"
  run_test(true_arr, max_sum, "sum_of_squares_6?")     # tests DOWNTO / UPTO

  puts "RUNNING TEST 7 (1..#{ true_arr.max })"
  run_test(true_arr, max_sum, "sum_of_squares_7?")     # original solution
end

def run_test(true_arr, max_sum, test_method)
  start = Time.now

  # iterate over all possible test values
  (1..max_sum).each do |test_num|
    result = send(test_method, test_num)
#    puts "#{ test_num } : #{ result }"
    case
    when true_arr.include?(test_num) && !result
      raise "function should have returned true! #{ test_num }"
    when !true_arr.include?(test_num) && result
      raise "function should have returned false! #{ test_num }"
    end
  end

  puts ""
  puts "*** TEST PASSED! #{ Time.now - start } ***"
  puts ""
rescue => e
  puts ""
  puts "!!! TEST FAILED : #{ e } !!!"
  puts ""
end

# this does not work - this attempts a loop up and fail when you exceed the test num
# but fails too aggressively
def sum_of_squares_1?(num)
  idx = 1

  while true
    (1..idx).each do |jdx|
      result = idx**2+jdx**2
      return true if result == num
      return false if result > num
    end

    idx += 1
  end
end

# using "regular" iteration
def sum_of_squares_2?(num)
  max_num = Math.sqrt(num).to_i

  (1..max_num).each do |idx|
    (1..idx).each do |jdx|
      result = idx**2+jdx**2
      return true if result == num
    end
  end

  return false
end

# using INT.upto
def sum_of_squares_3?(num)
  max_num = Math.sqrt(num).to_i

  1.upto(max_num) do |idx|
    1.upto(idx) do |jdx|
      result = idx**2+jdx**2
      return true if result == num
    end
  end

  return false
end

# using INT.downto
def sum_of_squares_4?(num)
  max_num = Math.sqrt(num).to_i

  max_num.downto(1) do |idx|
    idx.downto(1) do |jdx|
      result = idx**2+jdx**2
      return true if result == num
    end
  end

  return false
end

# using INT.upto / downto
def sum_of_squares_5?(num)
  max_num = Math.sqrt(num).to_i

  1.upto(max_num) do |idx|
    idx.downto(1) do |jdx|
      result = idx**2+jdx**2
      return true if result == num
    end
  end

  return false
end

# using INT.downto / upto
def sum_of_squares_6?(num)
  max_num = Math.sqrt(num).to_i

  max_num.downto(1) do |idx|
    1.upto(idx) do |jdx|
      result = idx**2+jdx**2
      return true if result == num
    end
  end

  return false
end

# original solution!
def sum_of_squares_7?(num)
  (1..num).each do |idx|
    (1..idx).each do |jdx|
      result = idx**2+jdx**2
      return true if result == num
    end
  end

  return false
end

test_to(20)
