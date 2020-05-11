# an array of all the possible winning combinations
WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 4, 8], [2, 4, 6], [0, 3, 6], [1, 4, 7], [2, 5, 8]]

# displays the tic tac toe board for the user
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# converts the users input of a numer 1-9 to an index of the board array (1-8)
def input_to_index(input)
  index = input.to_i - 1
end

# takes the users input and places their character in the correct spot on the board
def move(board, index, character)
  board[index] = character
end

# determines if the chosen position on the board is taken
def position_taken?(board, index)
  board[index] != " " && board[index] != ""
end

#determines if the move is a valid move
def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

computer chooses an index between 0 and 8
def computer_index
  rand(8)
end

# def computer_index
#   if turn_count(board) == 0
#     0
#   elsif turn_count(board) == 1
#     if !position_taken(board, 2)
#       return 2
#     else
#       return 6
#     end
#   elsif turn_count(board) == 2
#     if board[0] == "X" && board[2] == "X"
#       return 1
#     elsif board[0] == "X" && board[6] == "X"
#       return 4
#     elsif 

# end

# prompts user for their input and places their character on the board
# if the move is not vaild, the process repeats
def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# the computer chooses its turn placement here
def comp_turn(board)
  index = computer_index
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    comp_turn(board)
  end
end

# determines the turn number to be used in determining the current player
def turn_count(board)
  count = 0
  board.each do |space|
    if space == "X" || space == "O"
      count +=1
    end
  end
  count
end

# determines the current player (X or O) based on the turn number
def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

# determines if someone has won based on all possible winning combinations
def won?(board)
  WIN_COMBINATIONS.find do |winning_combo|
    winning_index_1 = winning_combo[0]
    winning_index_2 = winning_combo[1]
    winning_index_3 = winning_combo[2]
    
    position_1 = board[winning_index_1]
    position_2 = board[winning_index_2]
    position_3 = board[winning_index_3]
    
    (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
  end
end

# determines if the board is full
def full?(board)
  board.all? {|space| space == "X" || space == "O"}
end

# if the board is full and no one has won, returns true for a draw
def draw?(board)
  full?(board) && !won?(board)
end

# if there is a draw or someone has won the game, the game is over
def over?(board)
  draw?(board) || won?(board)
end

# if someone has won the game, it returns who that winner is
def winner(board)
  return board[won?(board)[0]] if won?(board)
end

# runs the game
# asks the player if they would like to play solo or with another player. chooses the correct path accordingly
# congratulates winner or announces a draw
def play(board)
  puts "Are you playing with another person or would you like to play against the computer?"
  puts "Please enter '1' for one player or '2' for two"
  choice = gets.strip
  if choice == "2"
    until over?(board)
      if current_player(board) == "X"
        puts "It's X's turn"
      elsif current_player(board) == "O"
        puts "It's O's turn"
      end
      turn(board)
    end
    
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "It's a draw!"
    end

  elsif choice == "1"
    until over?(board)
      puts "Now it's my turn..."
      comp_turn(board)
      break if won?(board)
      puts "Now it's your turn..."
      turn(board)
    end
    
    if won?(board)
      puts "Congratulations #{winner(board)}!"
    elsif draw?(board)
      puts "It's a draw!"
    end
  end
end