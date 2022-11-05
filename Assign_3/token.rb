# author : Ramish
# section 2
# CS 3520 Fall 2022
# this class build a toke based on the name and type
class Token
  attr_reader :name, :type
  # initialize method

  def initialize(name, type)
    @name = name
    @type = type
  end

  def to_s
    return "[" + @name.to_s + ":" + @type.to_s + "]"
  end
end