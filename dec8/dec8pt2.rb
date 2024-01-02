require 'pry'

def left_score(array, element, index)
  count = 0
  left_array = array.slice(0...index).reverse
  left_array.each do |num|
    count += 1 

    if element <= num
      return count 
    end
  end
  count
end

def right_score(array, element, index)
  count = 0
  right_array = array.slice((index + 1)..-1)
  right_array.each do |num|
    count += 1 

    if element <= num
      return count 
    end
  end
  count
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

scenic_scores = []

tree_rows.each_with_index do |row, row_idx|
  row.each_with_index do |tree, tree_idx|
    arr = []

    arr << left_score(row, tree, tree_idx)
    arr << right_score(row, tree, tree_idx)

    new_row = create_column_for_tree(tree_idx, tree_rows)
    arr << left_score(new_row, tree, row_idx)
    arr << right_score(new_row, tree, row_idx)

    
    arr.delete(0)
    # p "scenic-scores: #{arr}"
    # p "row #{row} row_idx #{row_idx} tree_idx #{tree_idx}"
    # p "new row #{new_row}"
    # p ""
    scenic_scores << arr.inject(&:*)
  end

end

# p tree_rows
p scenic_scores.max