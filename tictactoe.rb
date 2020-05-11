#!/usr/bin/env ruby

require_relative '../code/tic_tac_toe'

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

puts "Welcome to Tic Tac Toe!"
display_board(board)

play(board)