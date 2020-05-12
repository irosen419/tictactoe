#!/usr/bin/env ruby

require_relative '../tictactoe/tic_tac_toe.rb'

game = TicTacToe.new

puts "Welcome to Tic Tac Toe!"

game.display_board

game.play