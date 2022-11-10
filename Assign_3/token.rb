class Token
  attr_accessor :type, :text
  EOF = 15

  def initialize(text, type)
    @text = text
    @type = type
  end

  def self.EOF
    return -1
  end

  def to_s
    return "[#{@text}:#{@type.to_s}]"
  end

end