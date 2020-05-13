class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end
  # an array of all the possible winning combinations
  WIN_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 4, 8], [2, 4, 6], [0, 3, 6], [1, 4, 7], [2, 5, 8]]
  CORNERS = [0, 2, 6, 8]

  # displays the tic tac toe board for the user
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  # converts the users input of a numer 1-9 to an index of the board array (1-8)
  def input_to_index(input)
    index = input.to_i - 1
  end

  # takes the users input and places their character in the correct spot on the board
  def move(index, character)
    @board[index] = character
  end

  # determines if the chosen position on the board is taken
  def position_taken?(index)
    # puts "Now Index = #{index}"
    @board[index] != " " && @board[index] != ""
  end

  #determines if the move is a valid move
  def valid_move?(index)
    puts "Turn #{turn_count}"
    index.between?(0,8) && !position_taken?(index)
  end

  # returns the chosen index to the comp_turn method
  # if two indexes of a winning combo are filled by either X or O, the computer will win or block accordingly
  def computer_index
    unused_combos = []
    if turn_count == 0
      return CORNERS.sample
    elsif turn_count == 2
      return CORNERS.sample
    elsif turn_count == 4
      empty = nil
      WIN_COMBINATIONS.each do |combo|
        if @board[combo[0]] == "X" && @board[combo[1]] == "X" && (@board[combo[2]] == " " || @board[combo[2]] == "")
          empty = combo[2]
          puts "#{combo}"
          return combo[2]
        elsif @board[combo[1]] == "X" && @board[combo[2]] == "X" && (@board[combo[0]] == " " || @board[combo[0]] == "")
          empty = combo[0]
          puts "#{combo}"
          return combo[0]
        elsif @board[combo[0]] == "X" && @board[combo[2]] == "X" && (@board[combo[1]] == " " || @board[combo[1]] == "")
          empty = combo[1]
          puts "#{combo}"
          return combo[1]
        elsif @board[combo[0]] == "O" && @board[combo[1]] == "O" && (@board[combo[2]] == " " || @board[combo[2]] == "")
          empty = combo[2]
          puts "#{combo}"
          return combo[2]
        elsif @board[combo[1]] == "O" && @board[combo[2]] == "O" && (@board[combo[0]] == " " || @board[combo[0]] == "")
          empty = combo[0]
          puts "#{combo}"
          return combo[0]
        elsif @board[combo[0]] == "O" && @board[combo[2]] == "O" && (@board[combo[1]] == " " || @board[combo[1]] == "")
          empty = combo[1]
          puts "#{combo}"
          return combo[1]
        end
      end
      return CORNERS.sample if !empty
    elsif turn_count == 6
      empty = nil
      WIN_COMBINATIONS.each do |combo|
        if @board[combo[0]] == "X" && @board[combo[1]] == "X" && (@board[combo[2]] == " " || @board[combo[2]] == "")
          empty = combo[2]
          puts "#{combo}"
          return combo[2]
        elsif @board[combo[1]] == "X" && @board[combo[2]] == "X" && (@board[combo[0]] == " " || @board[combo[0]] == "")
          empty = combo[0]
          puts "#{combo}"
          return combo[0]
        elsif @board[combo[0]] == "X" && @board[combo[2]] == "X" && (@board[combo[1]] == " " || @board[combo[1]] == "")
          empty = combo[1]
          puts "#{combo}"
          return combo[1]
        end
      end
      WIN_COMBINATIONS.each do |combo|
        if @board[combo[0]] == "O" && @board[combo[1]] == "O" && (@board[combo[2]] == " " || @board[combo[2]] == "")
          empty = combo[2]
          puts "#{combo}"
          return combo[2]
        elsif @board[combo[1]] == "O" && @board[combo[2]] == "O" && (@board[combo[0]] == " " || @board[combo[0]] == "")
          empty = combo[0]
          puts "#{combo}"
          return combo[0]
        elsif @board[combo[0]] == "O" && @board[combo[2]] == "O" && (@board[combo[1]] == " " || @board[combo[1]] == "")
          empty = combo[1]
          puts "#{combo}"
          return combo[1]
        end
      end
      return CORNERS.sample if !empty
    else
      @board.each do |space|
        if space == " " || space == ""
          return @board.index(space)
        end
      end
    end
  end

  # prompts user for their input and places their character on the board
  # if the move is not vaild, the process repeats
  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  # the computer chooses its turn placement here
  def comp_turn
    index = computer_index
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      comp_turn
    end
  end

  # determines the turn number to be used in determining the current player
  def turn_count
    count = 0
    @board.each do |space|
      if space == "X" || space == "O"
        count +=1
      end
    end
    count
  end

  # determines the current player (X or O) based on the turn number
  def current_player
    turn_count.even? ? "X" : "O"
  end

  # determines if someone has won based on all possible winning combinations
  def won?
    WIN_COMBINATIONS.find do |winning_combo|
      winning_index_1 = winning_combo[0]
      winning_index_2 = winning_combo[1]
      winning_index_3 = winning_combo[2]
      
      position_1 = @board[winning_index_1]
      position_2 = @board[winning_index_2]
      position_3 = @board[winning_index_3]
      
      (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
    end
  end

  # determines if the board is full
  def full?
    @board.all? {|space| space == "X" || space == "O"}
  end

  # if the board is full and no one has won, returns true for a draw
  def draw?
    full? && !won?
  end

  # if there is a draw or someone has won the game, the game is over
  def over?
    draw? || won?
  end

  # if someone has won the game, it returns who that winner is
  def winner
    return @board[won?[0]] if won?
  end

  # runs the game
  # asks the player if they would like to play solo or with another player. chooses the correct path accordingly
  # congratulates winner or announces a draw
  def play
    puts "Please enter '1' for one player or '2' for two"
    choice = gets.strip
    if choice == "2"
      until over?
        if current_player == "X"
          puts "It's X's turn"
        elsif current_player == "O"
          puts "It's O's turn"
        end
        turn
      end
      
      if won?
        puts "Congratulations #{winner}!"
      elsif draw?
        puts "It's a draw!"
      end

    elsif choice == "1"
      until over?
        puts "Now it's my turn..."
        comp_turn
        break if won? || draw?
        puts "Now it's your turn..."
        turn
      end
      
      if won?
        puts "Congratulations #{winner}!"
      elsif draw?
        puts "It's a draw!"
      end
    end
  end
end