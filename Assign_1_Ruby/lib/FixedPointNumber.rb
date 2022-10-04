class FixedPointNumber
  @int_val = 0
  @q_val = 12
  attr_reader :int_val, :q_val
  def initialize(int_val, q_val)
    #Check if intVal is an integer
    if Integer === int_val then
      @int_val = int_val
      @q_val = q_val
      # Check if intVal is a float
    elsif Float === int_val then
        @int_val = (int_val * (2 ** q_val)).to_i
        @q_val = q_val
    end
  end

  # convert to double
  def to_double
    return @int_val.to_f / (2 ** @q_val)
  end

  #convert from one fixed point to another
  def to_Q_val(q_val)
    if (@int_val > q_val)
      return FixedPointNumber.new(@int_val >> (@q_val - q_val), q_val)
    elsif (@q_val < q_val) then
      return FixedPointNumber.new(@int_val << (q_val - @q_val), q_val)
    end
  end
  #
  # fixed point to string
  def to_s
    return @int_val.to_s + ", " + @q_val.to_s + ": " + + sprintf(" %.6f", self.to_double)
  end

  # #two fixed point numbers are equal if they have the same integer value and the same q value
  def equals(other)
    if (other.is_a?(FixedPointNumber)) then
      return @int_val == other.int_val && @q_val == other.q_val
    end
  end

  #add two fixed point numbers
  def add(other,q)
    return FixedPointNumber.new(@int_val + other.int_val, q)
  end

end

# a = FixedPointNumber.new(2.5, 12)
# b = FixedPointNumber.new(3.5, 12)
# puts a.to_s
# puts b.to_s
# puts a.equals(b)
# puts a.add(b, 12).to_s
# puts(FixedPointNumber.new(1.5, 2).to_s)