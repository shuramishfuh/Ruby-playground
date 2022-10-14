# author : Ramish
# section 2
# CS 3520 Fall 2022
# this class build a toke based on the name and type
class Token
  # initialize method
  def initialize(name, type)
    @name = name
    @type = type
  end

  def to_s
    return "[" + @name.to_s + ":" + @type.to_s + "]"
  end
end

# a = "12\"34".chars
# index_of_string = a.find_index("\"")
# b= a[0..index_of_string].join('').chop
# puts a.join[index_of_string+1..-1]
# puts b
# puts "Hel#7lo".index( /[^[:alnum:]]/ )