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
  run_test(true_arr, max_sum, "sum_of_squares_1?")

  puts "RUNNING TEST 2 (1..#{ true_arr.max })"
  run_test(true_arr, max_sum, "sum_of_squares_2?")

  puts "RUNNING TEST 3 (1..#{ true_arr.max })"
  run_test(true_arr, max_sum, "sum_of_squares_3?")

  puts "RUNNING TEST 4 (1..#{ true_arr.max })"
  run_test(true_arr, max_sum, "sum_of_squares_4?")
end

def run_test(true_arr, max_sum, test_method)
  start = Time.now

  # iterate over all possible test values
  (1..max_sum).each do |test_num|
    result = send(test_method, test_num)
#    puts "#{ test_num } : #{ result }"
    case
    when true_arr.include?(test_num) && !result
      raise "function should have returned true!"
    when !true_arr.include?(test_num) && result
      raise "function should have returned false!"
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


def sum_of_squares_1?(num)
  idx = 1
  jdx = 1

  while true
    (1..idx).each do |jdx|
      result = idx**2+jdx**2
      return true if result == num
      return false if result > num
    end

    idx += 1
  end
end

def sum_of_squares_2?(num)
#debugger if num == 173
  max_num = Math.sqrt(num).to_i

  (1..max_num).each do |idx|
    (1..idx).each do |jdx|
      result = idx**2+jdx**2
      return true if result == num
    end
  end

  return false
end

def sum_of_squares_3?(num)
#debugger if num == 173
  max_num = Math.sqrt(num).to_i

  1.upto(max_num) do |idx|
    1.upto(idx) do |jdx|
      result = idx**2+jdx**2
      return true if result == num
    end
  end

  return false
end

def sum_of_squares_4?(num)
#debugger if num == 173
  max_num = Math.sqrt(num).to_i

  max_num.downto(1) do |idx|
    idx.downto(1) do |jdx|
      result = idx**2+jdx**2
      return true if result == num
    end
  end

  return false
end


test_to(120)
