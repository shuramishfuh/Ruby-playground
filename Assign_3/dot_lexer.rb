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

  @array_of_tokens = []

  def initialize
    @array_of_tokens = []
  end

  def pure_string(word)
    if word.match(/[a-zA-Z0-9]+$/) && word.index(/[^[:alnum:]]/) == nil
      @array_of_tokens.push(Token.new(word, ID))
    else
      odd_char_position = word.index(/[^[:alnum:]]/)
      @array_of_tokens.push(Token.new(word[0..odd_char_position - 1], ID))
      # puts "illegal char " + word[odd_char_position]
      core(word[odd_char_position + 1..-1])
    end
  end

  def illegal_or_string(word)
    if word[word.length - 1] == "\""
      @array_of_tokens.push(Token.new(word, STRING))

      # string with special chars
    else
      word = word[1..-1].chars
      index_of_string = word.find_index("\"")
      sub_string = "\"" + word[0..index_of_string].join('')
      @array_of_tokens.push(Token.new(sub_string, STRING)) # check if string is valid
      word = word.join[index_of_string + 1..-1]
      core(word)
    end
  end

  def rbracket(word)
    if word.length > 1
      core(word[1..-1])
      @array_of_tokens.push(Token.new("]", RBRACK))
    else
      @array_of_tokens.push(Token.new("]", RBRACK))
    end
  end

  def lbracket(word)
    if word.length > 1
      @array_of_tokens.push(Token.new("[", LBRACK))
      core(word[1..-1])
    else
      @array_of_tokens.push(Token.new("[", LBRACK))
    end
  end

  def equals(word)
    if word.length > 1
      @array_of_tokens.push(Token.new(word[0], EQUALS)) # push the first char check here for error
      core(word[1..-1])
    else
      @array_of_tokens.push(Token.new(word, EQUALS))
    end
  end

  def semi(word)
    core(word.chop)
    @array_of_tokens.push(Token.new(";", SEMI))
  end

  def comma(word)
    core(word.chop)
    @array_of_tokens.push(Token.new(",", COMMA))
  end

  def core(word)

    if word == "="
      equals(word)
    elsif word.downcase == "digraph"
      @array_of_tokens.push(Token.new(word, DIGRAPH))
    elsif word.strip.empty?
    elsif word.downcase == "subgraph"
      @array_of_tokens.push(Token.new(word, SUBGRAPH))
    elsif word.downcase == "{"
      @array_of_tokens.push(Token.new(word, LCURLY))
    elsif word.downcase == "}"
      @array_of_tokens.push(Token.new(word, RCURLY))
    elsif word[0] == "["
      lbracket(word)
    elsif word[0] == "]"
      rbracket(word)
    elsif word[0] == ","
      comma(word)
    elsif word[word.length - 1] == ";"
      semi(word)
    elsif word[0] == "\""
      illegal_or_string(word)
    elsif word.downcase == "->"
      @array_of_tokens.push(Token.new(word, ARROW))
    elsif word == word.to_i.to_s
      @array_of_tokens.push(Token.new(word, INT))
    elsif word[0].match(/^[a-zA-Z]+$/)
      pure_string(word)
    end
  end

  def get_equal_and_other(word)
    if str.length > 1
      str = str.split("=")
      @temp = str[1] # add equals back to string
      str[1] = "="
      str.push(@temp)
      str.each do |word|
        core(word)
      end
    else
      core(str)
    end
  end

  def get_comma_and_other(word)
    if str.length > 1
      str = str.split(",")
      str.push(",")
      str.each do |word|
        core(word)
      end
    else
      core(str)
    end
  end

  def next_token
    # read file
    File.readlines("prog3_1.in").each do |line|
      line.split(' ').each do |str|
        if str.include?("{") and str.length == 2
          core(str[0])
          core(str[1])
        elsif str.include?("=") # check for equals
          get_equal_and_other(str)
        elsif str.include?(",") # check for comma
          get_comma_and_other(str)
        else
          core(str)
        end
      end
    end
    return @array_of_tokens
  end
end