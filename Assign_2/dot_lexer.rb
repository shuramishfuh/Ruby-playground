# author : Ramish
# section 2
# CS 3520 Fall 2022

# this class defines the token and their creation
require "/home/ramsi/RubymineProjects/ProgLang/Assign_2/token.rb"

class DotLexer

  ID = 1
  INT = 2
  STRING = 3
  LCURLY = 4
  RCURLY = 5
  SEMI = 6
  LBRACK = 7
  RBRACK = 8
  ARROW = 9
  EQUALS = 10
  DIGRAPH = 11
  SUBGRAPH = 12
  COMMA = 13
  WS = 14
  EOF = -1

  def initialize
    @fixed_point_list = []
  end

  @list_of_tokens = []

  # array of recognized characters
  def next_token

    # read file
    File.readlines("/home/ramsi/RubymineProjects/ProgLang/Assign_2/prog2.in").each do |line|
      line.split(' ').each do |word|
        if word.downcase == "digraph"
          puts Token.new(word, DIGRAPH)

        elsif word.downcase == "subgraph"
          puts Token.new(word, SUBGRAPH)

        elsif word.downcase == "{"
          puts Token.new(word, LCURLY)




        end
      end

    end
  end
end

n = DotLexer.new
n.next_token


