def __main__(argv)
  if argv.length != 2
    error("#{argv[0]}: invalid number of arguments\n")
  end

  source_code = SourceManager.new(argv[1])
  token = Tokenizer.run(source_code)
  CodeGenerator.run(token)
end
