module NodeKind
  ADD = "ADD"             # +
  SUB = "SUB"             # -
  MUL = "MUL"             # *
  DIV = "DIV"             # /
  NUM = "NUM"             # Integer
end

class Node
  attr_accessor :kind,    # node kind
                :lhs,     # left-hand node
                :rhs,     # right-hand node
                :val      # used if NodeKind::NUM

  def initialize(kind=nil, lhs=nil, rhs=nil, val=nil)
    @kind = kind
    @lhs = lhs
    @rhs = rhs
    @val = val
  end

  class << self
    def new_node(kind)
      return Node.new(kind, nil, nil, nil)
    end

    def new_binary(kind, lhs, rhs)
      return Node.new(kind, lhs, rhs, nil)
    end

    def new_num(val)
      return Node.new(NodeKind::NUM, nil, nil, val)
    end

    def unary(tok)
      if tok.equal("+")
        tok = tok.next
        return unary(tok)
      end
  
      if tok.equal("-")
        tok = tok.next
        num_node = new_num(0)
        node, rest = unary(tok)
        return new_binary(NodeKind::SUB, num_node, node), rest
      end
  
      return primary(tok)
    end

    def primary(tok)
      if tok.equal("(")
        tok = tok.next
        node, rest = expr(tok)
        rest = rest.skip(")")
        return node, rest
      end
  
      node = new_num(tok.get_number)
      rest = tok.next
      return node, rest
    end
  
    def mul(tok)
      node, rest = unary(tok)
  
      loop do
        if rest.equal("*")
          rest = rest.next
          rhs, rest = unary(rest)
          node = new_binary(NodeKind::MUL, node, rhs)
          next
        end
  
        if rest.equal("/")
          rest = rest.next
          rhs, rest = unary(rest)
          node = new_binary(NodeKind::DIV, node, rhs)
          next
        end
  
        return node, rest
      end
    end
  
    def expr(tok)
      node, rest = mul(tok)
  
      loop do
        if rest.equal("+")
          rest = rest.next
          rhs, rest = mul(rest)
          node = new_binary(NodeKind::ADD, node, rhs)
          next
        end
  
        if rest.equal("-")
          rest = rest.next
          rhs, rest = mul(rest)
          node = new_binary(NodeKind::SUB, node, rhs)
          next
        end
  
        return node, rest
      end
    end  
  end
end
