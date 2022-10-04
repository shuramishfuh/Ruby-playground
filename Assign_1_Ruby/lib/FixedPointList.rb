require_relative 'FixedPointNumber'
class FixedPointList
  @fixed_point_list = Array.new(10)
  @list_val = 12

  def set_q_val(q_val)
    @list_val = q_val
  end

  attr_reader :list_val

  #add a fixed point number to the list
  def add_fixed_point(fixed_point)
    @fixed_point_list.push(fixed_point)
  end

  #remove a fixed point number from the list
  def remove_fixed_point(fixed_point)
    @fixed_point_list.delete(fixed_point)
  end

  # print all the fixed point numbers in the list
  def print
    if @fixed_point_list.length == 0 then
      @fixed_point_list.each do |fixed_point|
        puts fixed_point.to_s
      end
    else
      puts FixedPointNumber.new(0, 12).to_s
    end
  end

  #find index of a fixed point number in the list
  def find(fixed_point)
    return @fixed_point_list.index(fixed_point)
  end

  # change q value of specific fixed point number in the list
  def change_to_q_val(fixed_point, q_val)
    @fixed_point_list[@fixed_point_list.index(fixed_point)] = fixed_point.to_Q_val(q_val)
  end

  #change list q value
  def change_list_q_val(q_val)
    puts "current q value was changed to #{q_val}"
    set_q_val(q_val)
  end

  #sum all the fixed point numbers in the list
  def sum()
    summed = FixedPointNumber.new(0, @list_val)
    @fixed_point_list.each do |fixed_point|
      summed = summed.add(fixed_point, @list_val)
    end
    puts " the sum is: #{summed.to_s}"
  end

  # end program
  def end_program
    puts "Program ended"
    exit
  end

  # run program
  def run
    puts "Welcome to the Fixed Point Number Program"
    puts "Please enter a command"

    while true
      puts "Enter command: "
      command, fixed_point = gets.chomp.chomp.split(' ')
      puts command
      if command.upcase == "A" then
        add_fixed_point(FixedPointNumber.new(fixed_point.to_f, @list_val.to_i))
      elsif command.upcase == "D" then
        remove_fixed_point(FixedPointNumber.new(fixed_point.to_f, @list_val.to_i))
      elsif command.upcase == "P" then
        print()
      elsif command.upcase == "S" then
        sum()
      elsif command.upcase == "Q" then
        change_list_q_val(q_val.to_i)
      elsif command.upcase == "X" then
        end_program()
      else
        puts "Invalid command"
      end
    end
  end

end

a = FixedPointList.new()
a.run()