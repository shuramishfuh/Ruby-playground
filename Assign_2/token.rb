# token class
class Token
  tokens = { 1 => "ID", 2 => "INT", 3 => "STRING", 4 => "LCURLY" 5 => "RCURLY", 6 => "SEMI", 7 => "LBRACK", 8 => "RBRACK", 9 => "ARROW", 10 => "EQUALS", 11 => "DIGRAPH", 12 => "SUBGRAPH", 13 => "COMMA", 14 => "WS" }
end

class Helpers

  def is_digit?(char)
    char =~ /[0-9]/
  end

  def is_letter?(char)
    char =~ /[a-zA-Z]/
  end

  def is_operator?(char)
    char =~ /[+\-*\/=<>]/
  end

  def is_punctuation?(char)
    char =~ /[.,;:()\[\]{}]/
  end

  def is_whitespace?(char)
    char =~ /\s/
  end

  def is_newline?(char)
    char =~ /\n/
  end

  def is_eof?(char)
    char =~ /\0/
  end

  def is_comment?(char)
    char =~ /#/
  end
end