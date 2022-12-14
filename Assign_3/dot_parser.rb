class DotParser
  @counter
  @tokens
  @token

  def initialize(lexer)
    @counter = 0
    @tokens = []
    @constant = {
      "ID" => 1, "INT" => 2, "STRING" => 3, "LCURLY" => 4, "RCURLY" => 5,
      "SEMI" => 6, "LBRACK" => 7, "RBRACK" => 8, "ARROW" => 9, "EQUALS" => 10,
      "DIGRAPH" => 11, "SUBGRAPH" => 12, "COMMA" => 13, "WS" => 14, "EOF" => 15
    }
    # read in all tokens
    begin
      t = lexer.next_token
      @tokens << t
    end while Token::EOF != t.type

    get_next_token
  end

  def graph
    puts "Start recognizing a digraph"
    must_match(:DIGRAPH)
    match_id(false)
    cluster
    puts "Finish recognizing a digraph"
    # if is_match(:EOF)
    #   exit
    # else
    #   graph
    # end
  end

  def stmt_list
    if nextTokenIs(:RCURLY) # empty statement list
      true
    else
      begin
        stmt
        if nextTokenIs(:SEMI)
          must_match(:SEMI)
        end
      end while !nextTokenIs(:RCURLY)
    end
  end

  def stmt
    if nextTokenIs(:SUBGRAPH)
      subgraph
      true
    elsif assignment
      true
    elsif edge_stmt
      true
    else
      false
    end
  end

  def edge_stmt
    puts "Start recognizing an edge statement"
    match_id_or_subgraph
    edge
    edge_rhs
    if nextTokenIs(:LBRACK)
      must_match(:LBRACK)
      attr_list
      must_match(:RBRACK)
    end
    puts "Finish recognizing an edge statement"
  end

  def match_id_or_subgraph
    if is_id
      match_id
    elsif nextTokenIs(:SUBGRAPH)
      subgraph
    else
      puts "expecting Property, edge or subgraph, but found #{@token.text}"
      exit
    end
  end

  def attr_list
    puts "Start recognizing a property"
    match_id
    if nextTokenIs(:RBRACK)
      puts "Finish recognizing a property"
      true
    else
      if nextTokenIs(:EQUALS)
        must_match(:EQUALS)
        match_id
      end
      if nextTokenIs(:COMMA)
        must_match(:COMMA)
        attr_list
      end
    end
    puts "Finish recognizing a property"
  end

  def edge_rhs
    match_id_or_subgraph
    if edge(false)
      match_id_or_subgraph
    end
  end

  def edge(raise = true)
    if nextTokenIs(:ARROW)
      must_match(:ARROW)
      true
    elsif @token.type == "__" # test for __ which is not a token
      @counter += 1
      get_next_token
      true
    else
      if raise
        puts "expected an edge but found #{@token.text}"
        exit
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
    c = cluster
    # while !c and @token.type != Token::EOF and (not nextTokenIs(:RCURLY))
    #   stmt_list
    # end
    puts "Finish recognizing a subgraph"
  end

  def get_next_token(counter = @counter)
    @token = @tokens[counter]
  end

  def must_match(token_type)
    if @token.type == @constant[token_type.to_s.upcase]
      @counter += 1
      get_next_token
      true
    else
      puts "expected a #{token_type} but found #{@token.text}"
      exit
    end
  end

  def match_id(raise = true)
    if @token.type == @constant["ID"] or @token.type == @constant["STRING"] or @token.type == @constant["INT"]
      @counter += 1
      get_next_token
      true
    else
      if raise
        puts "expected an id but found #{@token.text}"
        exit
      else
        false
      end
    end
  end

  def is_id(param = @token)
    if param.type == @constant["ID"] or param.type == @constant["STRING"] or param.type == @constant["INT"]
      true
    else
      false
    end
  end

  def nextTokenIs(token_type)
    if @token.type == @constant[token_type.to_s.upcase]
      true
    else
      false
    end
  end

  def assignment
    if is_id and @tokens[@counter + 1].type == @constant["EQUALS"] and is_id(@tokens[@counter + 2])
      puts "start recognizing a property"
      puts "Finnish recognizing a property"
      @counter += 3
      get_next_token
      true
    else
      false
    end
  end

  def cluster
    puts "Start recognizing a cluster"
    must_match(:LCURLY)
    stmt_list
    must_match(:RCURLY)
    if nextTokenIs(:LCURLY)
      cluster
    end
    puts "Finish recognizing a cluster"
  end

end