def __main__(argv)
  if argv[1] == "version"
    puts "v#{Mrbcc::VERSION}"
  else
    puts "Hello World"
  end
end
