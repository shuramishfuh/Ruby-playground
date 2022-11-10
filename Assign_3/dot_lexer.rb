# author : Ramish
# section 2
# CS 3520 Fall 2022

require_relative "token"
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
  EOF = 15

  # Initialize method to take in the input.
  def initialize
    @input = gets.chomp()
    while tmp = gets do
      @input = @input + tmp.chomp();
    end
  end

  # Compares the next lexeme to all token classes
  # to find a match. Similar implementation to the
  # getChar() method defined in the textbook.
  def next_token
    if isEOF
      getEOF
      return Token.new("EOF", EOF)
    elsif @input.length == 0
      return Token.new("EOF", EOF)
    elsif isDIGRAPH
      tk = Token.new(getDIGRAPH, DIGRAPH)
    elsif isSUBGRAPH
      tk = Token.new(getSUBGRAPH, SUBGRAPH)
    elsif isINT
      tk = Token.new(getINT, INT)
    elsif isSTRING
      tk = Token.new(getSTRING, STRING)
    elsif isLCURLY
      tk = Token.new(getLCURLY, LCURLY)
    elsif isRCURLY
      tk = Token.new(getRCURLY, RCURLY)
    elsif isSEMI
      tk = Token.new(getSEMI, SEMI)
    elsif isLBRACK
      tk = Token.new(getLBRACK, LBRACK)
    elsif isRBRACK
      tk = Token.new(getRBRACK, RBRACK)
    elsif isARROW
      tk = Token.new(getARROW, ARROW)
    elsif isEQUALS
      tk = Token.new(getEQUALS, EQUALS)
    elsif isCOMMA
      tk = Token.new(getCOMMA, COMMA)
    elsif isID
      tk = Token.new(getID, ID)
    elsif isWS
      getWS
      tk = next_token
    elsif isINVALID
      puts "illegal char: #{getINVALID}"
      tk = next_token
    else
      return Token.new("EOF", -1)
    end

    return tk
  end

  #Checks to see if the lexeme is an ID
  def isID()
    return /^[a-zA-z][0-9a-zA-Z_]*/.match(@input)
  end

  # Retreives the ID lexeme and removes the
  # lexeme from the input string.
  def getID()
    matched = @input.match(/^([a-zA-z][0-9a-zA-Z_]*)/)
    @input = @input.sub(/#{matched}/, "")
    return matched
  end

  #Checks to see if the lexeme is an INT
  def isINT()
    return @input.match(/^[0-9]+/)
  end

  # Retrieves the INT lexeme and removes the
  # lexeme from the input string.
  def getINT()
    matched = @input.match(/^([0-9]+)/)
    @input = @input.sub(/#{matched}/, '')
    return matched
  end

  #Checks to see if the lexeme is a STRING
  def isSTRING()
    return @input.match(/^"[\w]*"/)
  end

  # Retrieves the STRING lexeme and removes the
  # lexeme from the input string.
  def getSTRING()
    matched = @input.match(/^("[\w]*")/)
    @input = @input.sub(/#{matched}/, '')
    return matched
  end

  #Checks to see if the lexeme is a LCURLY
  def isLCURLY()
    return @input.match(/^\{/)
  end

  # Retrieves the LCURLY lexeme and removes the
  # lexeme from the input string.
  def getLCURLY()
    matched = @input.match(/^(\{)/)
    @input = @input.sub(/#{matched}/, '')
    return matched
  end

  #Checks to see if the lexeme is a RCURLY
  def isRCURLY()
    return @input.match(/^\}/)
  end

  # Retrieves the RCURLY lexeme and removes the
  # lexeme from the input string.
  def getRCURLY()
    matched = @input.match(/^(\})/)
    @input = @input.sub(/#{matched}/, '')
    return matched
  end

  #Checks to see if the lexeme is a SEMI
  def isSEMI()
    return @input.match(/^\;/)
  end

  # Retrieves the SEMI lexeme and removes the
  # lexeme from the input string.
  def getSEMI()
    matched = @input.match(/^(\;)/)
    @input = @input.sub(/#{matched}/, '')
    return matched
  end

  #Checks to see if the lexeme is a LBRACK
  def isLBRACK()
    return @input.match(/^\[/)
  end

  # Retrieves the LBRACK lexeme and removes the
  # lexeme from the input string.
  def getLBRACK()
    matched = @input.match(/^(\[)/)
    @input = @input.sub(/\[/, '')
    return matched
  end

  #Checks to see if the lexeme is an RBRACK
  def isRBRACK()
    return @input.match(/^\]/)
  end

  # Retrieves the RBRACK lexeme and removes the
  # lexeme from the input string.
  def getRBRACK()
    matched = @input.match(/^(\])/)
    @input = @input.sub(/#{matched}/, '')
    return matched
  end

  #Checks to see if the lexeme is an ARROW
  def isARROW()
    return @input.match(/^->/)
  end

  # Retrieves the ARROW lexeme and removes the
  # lexeme from the input string.
  def getARROW()
    matched = @input.match(/^(->)/)
    @input = @input.sub(/#{matched}/, '')
    return matched
  end

  #Checks to see if the lexeme is an EQUALS
  def isEQUALS()
    return @input.match(/^=/)
  end

  # Retrieves the EQUALS lexeme and removes the
  # lexeme from the input string.
  def getEQUALS()
    matched = @input.match(/^(=)/)
    @input = @input.sub(/#{matched}/, '')
    return matched
  end

  #Checks to see if the lexeme is a DIGRAPH
  def isDIGRAPH()
    return @input.match(/^digraph /i)
  end

  # Retrieves the DIGRAPH lexeme and removes the
  # lexeme from the input string.
  def getDIGRAPH()
    matched = @input.match(/^(digraph)/i)
    @input = @input.sub(/#{matched}/, '')
    return matched
  end

  #Checks to see if the lexeme is a SUBGRAPH
  def isSUBGRAPH()
    return @input.match(/^subgraph /i)
  end

  # Retrieves the SUBGRAPH lexeme and removes the
  # lexeme from the input string.
  def getSUBGRAPH()
    matched = @input.match(/^(subgraph)/i)
    @input = @input.sub(/#{matched}/, '')
    return matched
  end

  #Checks to see if the lexeme is a COMMA
  def isCOMMA()
    return @input.match(/^,/)
  end

  # Retrieves the COMMA lexeme and removes the
  # lexeme from the input string.
  def getCOMMA()
    matched = @input.match(/^(,)/)
    @input = @input.sub(/#{matched}/, '')
    return matched
  end

  #Checks to see if the lexeme is WS
  def isWS()
    return @input.match(/^\p{Space}/)
  end

  # Retrieves the WS lexeme and removes the
  # lexeme from the input string.
  def getWS()
    matched = @input.match(/^(\p{Space})/)
    @input = @input.sub(/#{matched}/, '')
    return matched
  end

  #Checks to see if the lexeme is INVALID
  def isINVALID()
    return @input.match(/^[^a-zA-Z0-9_"]/)
  end

  # Retrieves the INVALID lexeme and removes the
  # lexeme from the input string.
  def getINVALID()
    matched = @input.match(/^([^a-zA-Z0-9_"])/)
    @input = @input.sub(/#{matched}/, '')
    return matched
  end

  #Checks to see if the lexeme is INVALID
  def isEOF()
    return @input.match(/^\Z/)
  end

  # Retrieves the INVALID lexeme and removes the
  # lexeme from the input string.
  def getEOF()
    matched = @input.match(/^\Z/)
    @input = @input.sub(/#{matched}/, '')
    return matched
  end
end