=begin

Input:
-list of numbers in text file 
-space separates each "list"
-list of numbers represents total calories

Output: 
-maximum number of calories which represents the sum of a list

Examples:
1000 + 2000 + 3000 = 6000

Data Structure:
[1000, 2000, 3000, \n, 4000, 2000] -> [1000 2000 3000] [4000 2000]
split on the "newline character or the space"
-sum all the integers in the array

Algorithm:
-Read in the text file containing the "lists" of numbers -> split on the space/newline
[ [1000 2000 3000] [4000 1000] ] -> looking for an array of subarrays
-Iterate through that array, transform each array element into its sum
-Return the maximum sum from our array of sums

=end

input = File.read('input.txt')
str_arrays = input.split(/\n\n/).map { |list| list.split(/\n/) }
str_arrays.map! do |sub_arr|
  sub_arr.map(&:to_i).sum
end
p str_arrays.max(3).sum