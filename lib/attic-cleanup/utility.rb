module AtticCleanup
  class Utility < Thor
    include Thor::Actions

    desc "store", 
    "Choose a path or shortcut to store the contents of the given folder.
    custom paths are called by placing an '@' sign in front of it.
    example: @mypath
    
    -a => 'all'
    -f => 'force'\n\n"
    method_options :a => :boolean, :f => :boolean
    def store(input="")
      
      # Checks if the options are set
      if options[:a]
        a = true
      end
      if options[:f]
        f = true
      end
      
      # If the input for store has an "@" at the beginning
      # it's a shortcut.
      if input[0..0] == "@"
        c = AtticCleanup::Path::Custom.new
        # The input without the first character (the @ sign)
        c.name = input[1..-1]
        c.file = MyAttic::CUSTOM
        input = c.find_custom
      end
      # The input is the location, if the input had an @ sign
      # at the beginning, the custom path will be stored in input variable
      s = AtticCleanup::Storage::StoreFiles.new
      s.location = input
      s.check
      s.store(a, f)
    end

    desc "new", "Create a custom path.
    --name => 'Name for your custom path'
    --path => 'The path for your shortcut'\n\n"
    method_options :name => :string, :path => :string
    def new
      if options[:path] != "path" && options[:path] && options[:name] != "name" && options[:name]
        c = AtticCleanup::Path::Custom.new
        # Sets name and path, adds it to the custom_paths.txt file
        c.name = options[:name]
        c.path = options[:path]
        c.file = MyAttic::CUSTOM
        c.write
      else
        puts "Please enter a path and name"
      end
    end
    
    desc "shortcuts", "View all available shortcuts"
    # Show all the availible shortcuts from the custom_paths.txt file
    def shortcuts
      MyAttic::SHORTCUTS.each do |s|
        puts s
      end
    end
  end
end