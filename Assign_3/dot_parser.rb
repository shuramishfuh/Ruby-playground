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
  def is_match(token_type)
    if @token.type == @constant[token_type.to_s.upcase]
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
    puts "Start recognizing a digraph"
    must_match(:DIGRAPH)
    match_id(false)
    if is_match(:LCURLY)
      must_match(:LCURLY)
      if is_match(:RCURLY)
        must_match(:RCURLY)
      else
        stmt_list
        must_match(:RCURLY)
        puts "Finish recognizing a cluster"
      end

    else
      raise "Syntax error at line"
    end
  end

  def stmt
    if is_id
      must_match(:ID)
      must_match(:EQUALS)
      match_id_or_subgraph
    else
      edge_stmt
    end
  end

  def edge_stmt
    puts "Start recognizing an edge statement"
    match_id_or_subgraph
    edge
    edgeRHS
    if is_match(:LBRAK)
      must_match(:LBRAK)
      attr_list
      must_match(:RBRAK)
    end

    puts "Finish recognizing an edge statement"
  end

  #: check for errors
  def attr_list
    match_id
    if is_match(:EQUALS)
      must_match(:EQUALS)
      match_id
    end
    if is_match(:COMMA)
      must_match(:COMMA)
      attr_list
    end
  end

  def edgeRHS
    match_id_or_subgraph
    if edge(false)
      match_id_or_subgraph
    end
  end

  # @param [Boolean] pass false if not want to throw error
  def edge(raise = true)
    if is_match(:ARROW) or @token.name == @constant["__"]
      get_next_token
    else
      if raise
        raise "expected an edge but found #{@token.name}"
      else
        false
      end
    end
  end

  def subgraph
    puts "Start recognizing a subgraph"
    must_match(:SUBGRAPH)
    if is_id
      match_id
    end
    cluster
    puts "Finish recognizing a subgraph"
  end

  def cluster
    puts "Start recognizing a cluster"
    must_match(:LCURLY)
    if is_match(:RCURLY)
      must_match(:RCURLY)
    else
      stmt_list
      must_match(:RCURLY)
    end
    puts "Finish recognizing a cluster"
  end

  def match_id(raise = true)
    if @token.type == @constant["ID"] or @token.type == @constant["STRING"] or @token.type == @constant["INT"]
      get_next_token
    else
      if raise
        raise "Syntax error at line"
      else
        false
      end
    end
  end

  def match_id_or_subgraph(raise = true)
    if is_id
      match_id
    elsif is_match(:SUBGRAPH)
      subgraph
    else
      if raise
        raise "expected an id or subgraph but found #{@token.name}"
      else
        false
      end
    end
  end

  def is_id
    if @token.type == @constant["ID"] or @token.type == @constant["STRING"] or @token.type == @constant["INT"]
      true
    end
    false
  end
end

