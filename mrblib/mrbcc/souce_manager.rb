class SourceManager
  attr_accessor :pos

  def initialize(source_code)
    @pos = 0
    @@source_code = source_code
  end

  def move_pos(i=1)
    @pos += i
  end

  def leading_numbers
    i_str = ""
    while int?(@@source_code[@pos])
      i_str += @@source_code[@pos]
      move_pos
    end
    return i_str.to_i
  end

  def exists_leftover
    @@source_code.length > @pos
  end

  def peek(i=1)
    return @@source_code[@pos]
  end
end
