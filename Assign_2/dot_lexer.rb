# author : Ramish
# section 2
# CS 3520 Fall 2022

# this class defines the token and their creation
require_relative "token.rb"

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

  def core(word)

    if word.downcase == "digraph"
      puts Token.new(word, DIGRAPH)

    elsif word.strip.empty?

    elsif word.downcase == "subgraph"
      puts Token.new(word, SUBGRAPH)

    elsif word.downcase == "{"
      puts Token.new("{", LCURLY)

      # test for equal sign  as a single token or as part of a string
    elsif word.downcase == "="
      if word.length > 1
        puts Token.new(word, EQUALS)
        core(word[1..-1])
      else
        puts Token.new(word, EQUALS)
      end

    elsif word.downcase == "}"
      puts Token.new(word, RCURLY)

      # test for RBRACK   as a single token or as part of a string
    elsif word[0] == "["
      if word.length > 1
        puts Token.new("[", LBRACK)
        core(word[1..-1])
      else
        puts Token.new("[", LBRACK)
      end

      # test for  RBRACK  as a single token or as part of a string
    elsif word[0] == "]"
      if word.length > 1
        core(word[1..-1])
        puts Token.new("]", RBRACK)
      else
        puts Token.new("]", RBRACK)
      end

      # test for semicolon  aat end of a string
    elsif word[word.length - 1] == ";"
      core(word.chop)
      puts Token.new(";", SEMI)

      # test for String/ illegal  as a single token or as part of a string
    elsif word[0] == "\""
      if word[word.length - 1] == "\""
        puts Token.new(word, STRING)

        # string with special chars
      else
        word = word[1..-1].chars
        index_of_string = word.find_index("\"")
        sub_string = "\"" + word[0..index_of_string].join('')
        puts Token.new(sub_string, STRING)
        word = word.join[index_of_string + 1..-1]
        core(word)
      end

      # arrow
    elsif word.downcase == "->"
      puts Token.new(word, ARROW)

      # int case
    elsif word == word.to_i.to_s
      puts Token.new(word, INT)

      # pure string
    elsif word[0].match(/^[a-zA-Z]+$/)
      if word.match(/[a-zA-Z0-9]+$/) && word.index(/[^[:alnum:]]/) == nil
        puts Token.new(word, ID)
      else
        odd_char_position = word.index(/[^[:alnum:]]/)
        puts Token.new(word[0..odd_char_position - 1], ID)
        puts "illegal char " + word[odd_char_position]
        core(word[odd_char_position + 1..-1])
      end
    end
  end

  def next_token
    # read file
    File.readlines("/home/ramsi/RubymineProjects/ProgLang/Assign_2/prog2.in").each do |line|
      line.split(' ').each do |str|
        core(str)
      end
    end
  end
end