class CodeGenerator
  def self.run(token)
    puts(".intel_syntax noprefix\n")
    puts(".globl main\n")
    puts("main:\n")

    puts("  mov rax, #{token.get_number}\n")

    token = token.next

    while token.kind != TokenKind::EOF
      if token.equal("+")
        token = token.next
        puts("  add rax, #{token.get_number}\n")
        token = token.next
      end

      if token.equal("-")
        token = token.next
        puts("  sub rax, #{token.get_number}\n")
        token = token.next
      end
    end

    puts("  ret\n")
  end
end
