def int?(str)
  if str == nil
    return false
  end
  str.to_i.to_s == str.to_s
end

def whitespace?(str)
  str == " "
end

def ispunct?(c)
  [ "!", "\"", "#", "$", "%", "&", "'", "(", ")", # 0x21 ~ 0x29
    "*", "+", ",", "-", ".", "/",                 # 0x2a ~ 0x2f
    ":", ";", "<", "=", ">", "?",                 # 0x3a ~ 0x3f
    "@",                                          # 0x40
    "[", "\\", "]", "^", "_",                     # 0x5b ~ 0x5f
    "`",                                          # 0x60
    "{", "|", "}"                                 # 0x7b ~ 0x7d
  ].include?(c)
end

def error(msg)
  raise msg
end
