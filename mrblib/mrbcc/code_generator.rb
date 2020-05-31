class CodeGenerator
  @@top = 0

  class << self
    def get_register_name(idx)
      r = ["r10", "r11", "r12", "r13", "r14", "r15"]

      if idx < 0 || r.length < idx
        error("register out of range: #{idx}")
      end

      return r[idx]
    end

    def gen_expr(node)
      if node.kind == NodeKind::NUM
        puts("  mov #{get_register_name(@@top)}, #{node.val}")
        @@top += 1
        return
      end

      gen_expr(node.lhs)
      gen_expr(node.rhs)

      rd = get_register_name(@@top -2)
      rs = get_register_name(@@top -1)
      @@top -= 1

      case node.kind
      when NodeKind::ADD
        puts("  add #{rd}, #{rs}\n")
        return
      when NodeKind::SUB
        puts("  sub #{rd}, #{rs}\n")
        return
      when NodeKind::MUL
        puts("  imul #{rd}, #{rs}\n")
        return
      when NodeKind::DIV
        puts("  mov rax, #{rd}\n")
        puts("  cqo\n")
        puts("  idiv #{rs}\n")
        puts("  mov #{rd}, rax\n")
        return
      when NodeKind::EQ
        puts("  cmp #{rd}, #{rs}\n")
        puts("  sete al\n")
        puts("  movzb #{rd}, al\n")
        return
      when NodeKind::NE
        puts("  cmp #{rd}, #{rs}\n")
        puts("  setne al\n")
        puts("  movzb #{rd}, al\n")
        return
      when NodeKind::LT
        puts("  cmp #{rd}, #{rs}\n")
        puts("  setl al\n")
        puts("  movzb #{rd}, al\n")
        return
      when NodeKind::LE
        puts("  cmp #{rd}, #{rs}\n")
        puts("  setle al\n")
        puts("  movzb #{rd}, al\n")
        return
      else
        error("invalid expression")
      end
    end

    def get_return_value
      get_register_name(@@top - 1)
    end

    def run(token)
      node, rest = Node.expr(token)

      if rest.kind != TokenKind::EOF
        SourceManager.error_at(rest.pos, "extra token")
      end

      puts(".intel_syntax noprefix\n")
      puts(".globl main\n")
      puts("main:\n")

      puts("  push r12\n")
      puts("  push r13\n")
      puts("  push r14\n")
      puts("  push r15\n")

      gen_expr(node)

      puts("  mov rax, #{get_return_value}\n")

      puts("  pop r15\n")
      puts("  pop r14\n")
      puts("  pop r13\n")
      puts("  pop r12\n")

      puts("  ret\n")
    end
  end
end
