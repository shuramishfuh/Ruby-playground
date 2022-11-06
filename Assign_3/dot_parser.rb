class DotParser

  @constant
  @counter
  @lexer

  def initialize(lexer)
    @counter = -1
    @constant = {
      "ID" => 1, "INT" => 2, "STRING" => 3, "LCURLY" => 4, "RCURLY" => 5,
      "SEMI" => 6, "LBRACK" => 7, "RBRACK" => 8, "ARROW" => 9, "EQUALS" => 10,
      "DIGRAPH" => 11, "SUBGRAPH" => 12, "COMMA" => 13, "WS" => 14, "EOF" => -1
    }
    @lexer = lexer.next_token
    @token = get_next_token
  end

  def get_next_token
    @counter += 1
    @token = @lexer[@counter]
  end

  # check if match token
  def if_match(token_type)
    if @token.type == @constant[token_type.to_s.upcase]
      get_next_token
      return true
    else
      return false
    end
  end


  def edge_stmt
    if if_match(:ID) or if_match(:SUBGRAPH)
      edge
      edgeRHS
      must_match(:LBRACK)
      attr_list
      must_match(:RBRACK)
    end
  end

  # must match the token type or raise an error
  def must_match(token_type)
    if @token.type == @constant[token_type.to_s.upcase]
      get_next_token
    else
      raise "Syntax error at line"
    end
  end

  def graph
    must_match(:DIGRAPH)
    if match_id
      must_match(:LCURLY)
      stmt_list
      must_match(:RCURLY)
    else
      raise "Syntax error at line"
    end
  end

  def stmt_list
    stmt
    stmt_list_prime
  end


  #TODO: check for errors
  def attr_list
    if match_id
      must_match(:EQUALS)
      match_id
      if @token.type == @constant["ID"]
        match_attr_list
      end
    else
      raise "Syntax error at line"
    end
  end

  #TODO: ask  for clarification about this method
  def edgeRHS
    if if_match(:SUBGRAPH) or match_id
      must_match(:LCURLY)
      match_edge
      match_edgeRHS
    end

  end

  def edge
    if @token.type == @constant["ARROW"] or @token.name == @constant["__"]
      get_next_token
      return true
    else
      return false
    end
  end

  def match_id
    if @token.type == @constant["ID"] or @token.type == @constant["string"] or @token.type == @constant["INT"]
      get_next_token
      return true
    else
      return false
    end
  end

  def subgraph
    must_match(:SUBGRAPH)
    if match_id
      must_match(:LCURLY)
      stmt_list
      must_match(:RCURLY)
    else
      raise "Syntax error at line"
    end

  end

  def stmt_list_prime
    if @token.type == :ID
      stmt
      stmt_list_prime
    end
  end

  def stmt
    if @token.type == :@constant["ID"]
      must_match(:id)
      must_match(:EQUALS)
      must_match(:id)
      must_match(:semicolon)
    elsif @token.type == :edgeop
      must_match(:edgeop)
      must_match(:id)
      must_match(:semicolon)
    else
      raise "Syntax error at line #{@lexer.line}, column #{@lexer.column}"
    end
  end
end

