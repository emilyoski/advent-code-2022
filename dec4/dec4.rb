=begin

Input:
-List of section pair assignments
-One line is a pair of section assignments
-each section assignment is split by a comma

Output:
-one of the assignment fully contains the other
  2-8 fully contains 3-7
-cannot be partially contained
-number of assignment pairs that fully contain another

Example:
5-7 [5 6 7]
7-9 [7 8 9] -> NO

[2 3 4 5 6 7 8]
[3 4 5 6 7] -> YES

Data Structure
[ [2 4] [6 8] ] contained in another array
subarray of the pair -> each section assignment is an array

Algorithm:
-Break the input into subarrays
  -each newline character represents a new pair
  -each comma splits the section assignment
  -lower and upper bounds (inclusive) split by -
  -ensure all integers
-initialize count of pairs to 0
-Iterate through all the pairs
  -method to see if range contains the other
    -create a range from the second values
    -from the first value up to the final value
    -return false if the value is not in the range
    -else return true
  -pass first range vs second, pass second range vs the first
  -if one assignment contains the other then increment one
-Return the count

=end

def range_included?(pair_one, pair_two)
  range = (pair_two[0]..pair_two[1]).to_a
  pair_one[0].upto(pair_one[1]) do |num|
    return true if range.include?(num)
  end
  false
end

section_assign = File.read('input.txt').split(/\n/).map do |ele|
  ele.split(/,/).map do |range|
    range.split(/-/).map { |value| value.to_i }
  end
end

# p section_assign
count = 0

section_assign.each do |pair|
  if range_included?(pair[0], pair[1]) || range_included?(pair[1], pair[0])
    count += 1
  end
end

p count
