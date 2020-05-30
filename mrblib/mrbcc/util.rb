def int?(str)
  if str == nil
    return false
  end
  str.to_i.to_s == str.to_s
end

def whitespace?(str)
  str == " "
end

def error(msg)
  raise msg
end
