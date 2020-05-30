class CodeGenerator
  def self.run(source_code)
    puts(".intel_syntax noprefix\n")
    puts(".globl main\n")
    puts("main:\n")
    puts("  mov rax, #{source_code.leading_numbers}\n")
  
    while source_code.exists_leftover
      if source_code.peek == "+"
        source_code.move_pos
        puts("  add rax, #{source_code.leading_numbers}\n")
        next
      end
  
      if source_code.peek == "-"
        source_code.move_pos
        puts("  sub rax, #{source_code.leading_numbers}\n")
        next
      end
  
      error("unexpected character: '#{source_code.peek}'\n")
    end
  
    puts("  ret\n")
  end
end
