#!/usr/bin/env ruby

require_relative '../tictactoe/tic_tac_toe'

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

puts "Welcome to Tic Tac Toe!"
puts "Are you playing with another person or would you like to play against the computer?"

play(board)