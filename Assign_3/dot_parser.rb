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
      true
    else
      false
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
      if @token.type == @constant["RCURLY"]
        must_match(:RCURLY)
      else
        stmt_list
      end
    else
      raise "Syntax error at line"
    end
  end

  def stmt
    if if_match(:SUBGRAPH)
      subgraph
    elsif match_id
      if if_match(:ARROW)
        edge_stmt
      else
        must_match(:EQUALS)
        must_match(:id)
      end
    else
      edge_stmt
    end
  end

  def stmt_list
    stmt
    if @token.type == @constant["SEMI"]
      must_match(:SEMI)
    end
  end

  #TODO: check for errors will have invalid syntax
  def edge_stmt
    if match_id
      if if_match(:LBRACK)
        attr_list
        must_match(:RBRACK)
      else
        edge
        edgeRHS
      end
    elsif if_match(:SUBGRAPH)
      subgraph
    else
      raise "Syntax error at line"
    end
  end

  #TODO: check for errors
  def attr_list
    must_match_id
    must_match(:EQUALS)
    must_match_id
    if if_match(:COMMA)
      attr_list
    end
  end

  #TODO: ask  for clarification about this method
  def edgeRHS
    if match_id
      edge
      if !match_id
        raise "Syntax error at line"
      end
    else
      must_match(:SUBGRAPH)
      if !match_id
        raise "Syntax error at line"
      end
    end

  end

  #TODO: check __  not sure what this is
  def edge
    if @token.type == @constant["ARROW"] or @token.name == @constant["__"]
      get_next_token
      true
    else
      false
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

  def match_id
    if @token.type == @constant["ID"] or @token.type == @constant["STRING"] or @token.type == @constant["INT"]
      get_next_token
      true
    else
      false
    end
  end

  def is_id
    if @token.type == @constant["ID"] or @token.type == @constant["STRING"] or @token.type == @constant["INT"]
      get_next_token
    else
      raise "Syntax error at line"
    end
  end
end

