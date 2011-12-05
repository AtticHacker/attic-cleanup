module AtticCleanup
  module Init
    
    # Default text for the custom_paths.txt file
    CUSTOM_FILE   = "#Write all your custom paths here.
#Or generate them with the 'attic-cleanup new' command
#Write all your custom paths like the examples, no extra spaces.
doc #{File.join(ENV['HOME'], 'Documents')}
pic #{File.join(ENV['HOME'], 'Pictures')}
mus #{File.join(ENV['HOME'], 'Music')}
mov #{File.join(ENV['HOME'], 'Movies')}
dow #{File.join(ENV['HOME'], 'Downloads')}"

    # Default text for the default_path.txt file
    DEFAULT_FILE  = "#Write your default location here.
#{File.join(ENV['HOME'], 'Desktop')}"
    
    # Default text for the ignore_files.txt file
    IGNORE_FILE = "#Write all the files/folders you want to ignore here.
#Don't write any spaces before or after the paths, just write it like the examples.
#{File.join(ENV['HOME'], 'Desktop')}
#{File.join(ENV['HOME'], 'Documents')}
#{File.join(ENV['HOME'], 'Pictures')}
#{File.join(ENV['HOME'], 'Music')}
#{File.join(ENV['HOME'], 'Movies')}
#{File.join(ENV['HOME'], 'Downloads')}
#{File.join(ENV['HOME'], 'Dropbox')}
#{File.join(ENV['HOME'], 'MyAttic')}"

    # Checks if folder exists, if it doesn't it will be created
    def self.check_folder(value)
      if !File.directory? value
        FileUtils.mkdir(value)
        puts "#{value} doesn't exist yet.\nCreating #{value}.."
      end
    end
    
    # Checks if file exists, if it doesn't it will be created
    # and depending on which file, the default text will be set
    def self.check_file(value)
      if !File.exist?(value)
        File.open(value, 'w') do |w| 
          if value == MyAttic::CUSTOM
            text = CUSTOM_FILE
          elsif value == MyAttic::DEFAULT
            text = DEFAULT_FILE
          elsif value == MyAttic::IGNORE
            text = IGNORE_FILE
          end
          w.write(text)
        end
      end
    end
    
    # Delete all folders in MyAttic that are empty
    def self.clear
      attic_folders = Dir.glob(File.join(MyAttic::ATTIC, "*"));
      attic_folders.each do |f|
        if f == MyAttic::CUSTOM || f == MyAttic::LOG || f == MyAttic::TODAY || f == MyAttic::DEFAULT || f == MyAttic::IGNORE
        elsif Dir[File.join(f, "/*")].empty?
          FileUtils.rm_rf(f)
        end
      end
    end
  end
end
