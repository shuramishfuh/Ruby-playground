# Course Number and Name:
# Section:
# Student Name:


# This is the main class for program3,
# which was provided by the instructor.

require_relative 'dot_lexer'
require_relative 'dot_parser'

# You may use the following line to redirect stdin to this file, or
# read from the file directly in DotLexer initialize() method
$stdin.reopen('Prog3_1.in')

lexer = DotLexer.new

parser = DotParser.new(lexer)

parser.graph # start parsing from the topmost EBNF grammar rule
