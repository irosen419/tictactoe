#!/usr/bin/env ruby

require_relative '../tictactoe/tic_tac_toe'

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
game = TicTacToe.new
puts "Welcome to Tic Tac Toe!"
game.display_board
puts "Are you playing with another person or would you like to play against the computer?"

game.play