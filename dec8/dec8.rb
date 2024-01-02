=begin

Input: grid of equal sides length
-each number represents the height of the trees
-comparing to the other trees in the same row or same column

Output: number representing the number of trees that are visible from outside
-visible includes the trees on the outside edge
-visible includes those "off edge" trees where all of the other trees
  between it and an edge of the grid are shorter than it (not visible if 
  the height is the same)

Examples:
3 0 3 7 3
2 5 5 1 2
6 5 3 3 2
3 3 5 4 9
3 5 3 9 0

-> really leaves the middle 9 because outside are visible
5 5 1
5 3 3
3 5 4
will be visible if shorter (not visible behind same value);
  just needs to be visible in one direction to be visible
-> need to check visibility on the "center trees"
-> need to check visibility by comparing to the rest of the numbers in the row 
  OR comparing to the rest of the numbers in the column 

Data Structure:
-Arrays of rows? -Arrays of columns?
-Hash comparing the column or rows?
-Cannot double count them
[3 0 3 7 3]
[2 5 5 1 2]
[6 5 3 3 2]
[3 3 5 4 9]
[3 5 3 9 0]

comparing the rows and then only evaluate columns if needed
  aka [ 0 5 5 3 5 ] for second column

Algorithm:

-Read in the text file, creating an array of arrays (representing the row in digits)
-Initialize a visible count to 0
-Iterate through each array
  -if first element, increment visible count by 1
  -if last element, increment visible count by 1
  -check the row for visibility
    -from start of the array to that value, iterate through &
      all values are less than that value
    -from that value to the end of the array, iterate through &
      all values are less than that value
  -check the column for visibility
    -take the index that we are on, form an array of that column
      -from start of the array to that value, iterate through &
        all values are less than that value
      -from that value to the end of the array, iterate through &
        all values are less than that value
  -next array
-Return the column

=end
require 'pry'

def first_element?(index)
  index == 0
end

def last_element?(index, array)
  index == (array.length - 1)
end

def visible_for_side?(array, element)
  array.each do |num|
    if num >= element
      return false
    end
  end
  true
end

def tree_visible_in_row?(row, tree_index)
  visible_for_side?(row.slice(0...tree_index), row[tree_index]) ||
  visible_for_side?(row.slice((tree_index + 1)..-1), row[tree_index])
end

def create_column_for_tree(index, grid)
  arr = []
  grid.each do |row|
    number = row[index]
    arr << number
  end
  arr
end

tree_rows = File.read('input.txt').split(/\n/).map do |digits|
  digits.chars.map(&:to_i)
end

visible_count = 0
visible_nums = []


tree_rows.each_with_index do |row, row_idx|
  row.each_with_index do |tree, tree_idx|

    if first_element?(tree_idx)
      visible_count += 1
      # visible_nums << [tree, tree_idx, row_idx]
      # binding.pry
    elsif first_element?(row_idx)
      visible_count += 1
      # visible_nums << [tree, tree_idx, row_idx]
      # binding.pry
    elsif last_element?(tree_idx, row)
      visible_count += 1
      # visible_nums << [tree, tree_idx, row_idx]
      # binding.pry
    elsif last_element?(row_idx, row)
      visible_count += 1
      # visible_nums << [tree, tree_idx, row_idx]
      # binding.pry
    elsif tree_visible_in_row?(row, tree_idx)
      visible_count += 1
      # visible_nums << [tree, tree_idx, row_idx]
      # binding.pry
    else
      new_row = create_column_for_tree(tree_idx, tree_rows)
      
      if tree_visible_in_row?(new_row, row_idx)
        visible_count += 1 
        # visible_nums << [tree, tree_idx, row_idx]
        # binding.pry
      end
    end
  end

end

# p tree_rows
p visible_count
# p visible_nums