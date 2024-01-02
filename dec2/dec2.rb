=begin

Input:
-List of each "round"
-Each "round" exists of their play (first character A B C)
  and our play (second character X Y Z)
-A (rock) B (paper) C (scissors)
-X (rock) Y (paper) Z (scissors)

Output:
-Sum of all the scores from each round
-Single round's score = (MOVE WE CHOSE X Y Z) and (OUTCOME OF ROUND)
-X (1 ; Rock) Y (2 ; Paper) Z (3 ; Scissors)
-0 points for a loss; 3 points for a draw; 6 if we won
-Rock defeats scissors; Scissors defeats paper; paper defeats rock

Example:
A Y -> opponent is rock (A), i'm paper (Y); paper = 2 points and win = 6 points
  8 points for this round
& continued on -> sum all rounds for total score

Data Structure:
[ [A Y] [B X] [C Z] ] -> each subarray is a round
  data structure for determining the outcome; data structure for move points

Algorithm:
-create data structure for determining score of outcome
-create data structure for move points
-Read in the text file with the rounds
-Break into each round an element in an array -> break the two moves into subarray
-Iterate through the array and transform the subarray to the score from the round
  -first element to be the outcome of the round
  -second element to be point of your score
  -add the two together for round score
-Sum the array for the total score

Continued Algorithm:
-create a data structure that will find the move that i need to make and return points
  for the move
-create a data structure that will return points for the game outcome
-update the data structures and update the names

=end

SCORE_MOVE = { 'A' => { 'X' => 3, 'Y' => 1, 'Z' => 2 },
                'B' => { 'X' => 1, 'Y' => 2, 'Z' => 3 },
                'C' => { 'X' => 2, 'Y' => 3, 'Z' => 1 }}

SCORE_GAME = { 'X' => 0, 'Y' => 3, 'Z' => 6 }

total_rounds = File.read('input.txt').split(/\n/).map! { |round| round.split(" ")}
total_rounds.map! do |round|
  SCORE_MOVE[round[0]][round[1]] + SCORE_GAME[round[1]]
end
p total_rounds.sum

