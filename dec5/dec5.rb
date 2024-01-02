require 'pry'

input = File.read('input.txt').split(/\n\n/)
moves = input[1].split(/\n/).map{ |move| move.split(' ') }
start_stack = input[0].split(/\n/)
stack_number = start_stack.pop.chars.map(&:to_i).max
stack_line_length = (stack_number * 3) + (stack_number - 2)

stacks = {}
1.upto(stack_number) do |num|
  stacks[num] = []
end

start_stack.reverse.each do |stack_line|
  index = 1
  current_stack = 1
  until index > stack_line_length
    if ('A'..'Z').to_a.include?(stack_line[index])
      stacks[current_stack] << stack_line[index]
    end
    index += 4
    current_stack += 1
  end
end

def move_from_to(stacks, old_stack, new_stack)
  crate = stacks[old_stack].pop
  stacks[new_stack] << crate
end

def new_crane_move_from_to(stacks, crate_num, old_stack, new_stack)
  shift_crates = []
  crate_num.times do
    crate = stacks[old_stack].pop
    shift_crates << crate
  end
  shift_crates.reverse.each do |incoming_crate|
    stacks[new_stack] << incoming_crate
  end
end

moves.each do |move|
  new_crane_move_from_to(stacks, move[1].to_i, move[3].to_i, move[5].to_i)
end

answer = ""
stacks.values.each do |stack|
  answer << stack[-1]
end

p answer

