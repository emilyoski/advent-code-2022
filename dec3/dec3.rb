=begin

Problem:
-two compartments; all items of given type are meant to
  go into exactly one of the two compartments
-elf failed to follow this rule for exactly one item type
-list of all the items currently in each rucksack and
  need to find error


Input: 
-every item is identified by single lowercase and uppercase letter
  (a and A are different types of items)
-list of items given as characters all on a single line
-rucksack always has the same number of items in each of
  the two compartments (first half is first compartment)
-each line is a rucksack; split in half for first/second compartment
-the item type that appears in both compartments is the error
-each item type can be converted to a priority
  lowercase items a - z have priorities 1 - 26
  uppercase items A - Z have priorities 27 - 52

Output:
-determine the item type in both compartments in each rucksack
-find the priority of the item type
-sum all the priorities 

Examples:
ttgJtRGJQctTZtZT
ttgJtRGJ      QctTZtZT (t) in both

Data Structure:
-split the input into each rucksack based on newline
-split the rucksack into compartments
ttgJtRGJ    QctTZtZT
[t t g J t R G J]
-iterate through the characters in the first compartment,
  look for a match for that in the second compartment
-data structure for the alphabet -> using index for priority

Algorithm:
-Input and split into rucksacks (array)
-Transform the array into priority scores
  -Method for finding the "error" and pass error to get score
    -Break the compartment in half 
    (divide by 2, 0 up to not including half #)
    -Iterate through the characters of the first half,
      -look and see if the character is in the second half
      -return the character if it is in the second half
  -Method for alphabet array for "priority score"
    -take the letter given
    -find the lowercase version in an alphabet array and return the index
    -if the letter is lowercase, add 1
    -if the letter is uppercase, add 27
-Sum the priority scores

=end

require 'pry'

def find_error_in(ruck)
  half = (ruck.length) / 2
  ruck.slice(0...half).chars do |char|
    return char if ruck.slice(half..ruck.length).include?(char)
  end
end

def find_priority_score(letter)
  alphabet = ('a'..'z').to_a
  score = alphabet.index(letter.downcase)
  letter == letter.downcase ? score + 1 : score + 27
end

def find_common_letter(group)
  group[0].chars do |char|
    return char if group[1].include?(char) && group[2].include?(char)
  end
end

rucksacks = File.read('input.txt').split(/\n/)

three_elves = []
first_index = 0

loop do
  three_elves << rucksacks[first_index..(first_index + 2)]
  first_index += 3
  break if first_index >= rucksacks.length
end

p three_elves

three_elves.map! do |rucksack|
  error = find_common_letter(rucksack)
  find_priority_score(error)
end

p three_elves.sum