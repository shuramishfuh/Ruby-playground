# author : Ramish
# section 2
# CS 3520 Fall 2022
#
# This is the main class for program2, which was provided by the instructor.
# The only modification is the commented out line used for input files when debugging.
#

require_relative "dot_lexer.rb"

# Uncomment this line for debugging. Must place Prog2.in with desired input
# in the same folder as your ruby files.
#$stdin.reopen("Prog2.in")

lexer = DotLexer.new

t = lexer.next_token

#define EOF as a constant in class Token that is different from all valid token types

# while Token::EOF != t.type do
#   puts t
#   t = lexer.next_token
# end

puts "Lexical analysis is finished!"
