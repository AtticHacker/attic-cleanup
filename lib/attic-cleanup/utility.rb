module AtticCleanup
  class Utility < Thor
    include Thor::Actions

    desc "store", 
    "Choose a path or shortcut to store the contents of the given folder.
    custom paths are called by placing an '@' sign in front of it.
    example: @mypath
    You can also store from one place to another, example:
    attic-cleanup store @doc @myproject
    Now you can choose files / folders from the @doc path and send them to the @myproject folder.
    
    -a => 'all'
    -f => 'force'\n\n"
    method_options :a => :boolean, :f => :boolean
    def store(location="", destination="")
      
      # Checks if the options are set
      if options[:a]
        a = true
      end
      if options[:f]
        f = true
      end

      # The input is the location, if the input had an @ sign
      # at the beginning, the custom path will be stored in input variable
      c = AtticCleanup::Path::Custom.new
      s = AtticCleanup::Storage::StoreFiles.new
      if destination != nil && destination != ""
        destination = c.check_shortcut(destination)
        s.destination = destination
        s.check = destination
      else
        destination = MyAttic::TODAY
        s.destination = destination
        s.check = s.destination
      end
      location = c.check_shortcut(location)
      s.location = location
      location = s.location
      s.check = location
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
    
    desc "default", "Set a default path for store."
    def default(input)
      c = AtticCleanup::Path::Custom.new
      input = c.check_shortcut(input)
      AtticCleanup::Path::Custom.set_default(input)
    end
    
    desc "ignore", "Add a file or folder you want to ignore."
    def ignore(input)
      AtticCleanup::Path::Custom.set_ignore(input)
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
