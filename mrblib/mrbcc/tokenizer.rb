module TokenKind
  RESERVED = "RESERVED"
  NUM = "NUM"
  EOF = "EOF"
end

class Token
  attr_accessor :code_pos, :kind, :len, :next, :val

  def initialize(code_pos=nil, kind=nil, len=nil, _next=nil, val=nil)
    @code_pos = code_pos
    @kind = kind
    @len = len
    @next = _next
    @val = val
  end

  def get_number
    if @kind != TokenKind::NUM
      SourceManager.error_at(@code_pos, "expected a number")
    end
    return @val
  end

  def equal(s)
    return s.length == @len && s == @val
  end

  def skip(s)
    unless equal(s)
      error_at(@code_pos, "expected '#{s}'")
    end
    return @next
  end

  class << self
    def new_token(code_pos, kind, cur)
      token = Token.new
      token.code_pos = code_pos
      token.kind = kind
      cur.next = token
      return token
    end
  
    def tokenize(source_code)
      head = Token.new
      cur = head
  
      while source_code.exists_leftover
        if whitespace?(source_code.peek)
          source_code.move_pos
          next
        end
  
        if int?(source_code.peek)
          cur = new_token(source_code.pos, TokenKind::NUM, cur)
          cur_tmp = source_code.pos
          cur.val = source_code.leading_numbers
          cur.len = source_code.pos - cur_tmp
          next
        end
  
        if ispunct?(source_code.peek)
          cur = new_token(source_code.pos, TokenKind::RESERVED, cur)
          cur.len = 1
          cur.val = source_code.peek
          source_code.move_pos
          next
        end
  
        SourceManager.error_at(source_code.pos, "invalid token")
      end
  
      cur = new_token(source_code.pos, TokenKind::EOF, cur)
      return head.next
    end  
  end
end

class Tokenizer
  def self.run(source_code)
    return Token.tokenize(source_code)
  end
end
