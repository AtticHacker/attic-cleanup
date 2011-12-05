#!/usr/bin/env ruby
module AtticCleanup
  module Storage
    class StoreFiles
      
      attr_accessor :destination
            
      # Easy method for input
      def input
        STDOUT.flush
        @input = $stdin.gets.chomp
      end

      def location
        @location
      end

      # Sets the location of the store method
      # If the location wasn't set, the default
      # location will be used from the default_path.txt file
      def location= ( value )
        if value == "" || value == nil
          value = AtticCleanup::Path::Custom.default
        elsif value == "."
          Dir.chdir(".")
          value = Dir.getwd()
          puts Dir.getwd()
        end
        @location = value
      end
      
      # Checks if the selected path exists
      def check
        @check
      end
      
      def check=(value)
        if !File.directory? value
          puts "Invalid path "  + value
          exit 1
        end
      end
      
      # Puts the string of numbers in an array and removes the ','
      def bundle(input)
        bundle = input
        bundle = bundle.scan( /\d+/ )
        bundle.map!{ |bundle| bundle.to_i }
        @bundle_items = bundle
        @bundle_count = bundle.count
        
        # If the user typed 'all' instead of numbers, every file will
        # be set into the the array.
        if @input == "all"
          @bundle_items = []
          p = 0
          folder_files = AtticCleanup::Storage::FolderFiles.new
          folder_files.all_files = location
          folder_files.all_files.each do
            @bundle_items[p] = p
            p += 1
            @bundle_count = "all"
          end
        end
      end
  
      
      def store(a, f)
        folder_files = AtticCleanup::Storage::FolderFiles.new
        # Selects all files from the current location
        folder_files.all_files = location
        
        # If option a is nil, the files will have to be selected manually
        if a == nil
          i = 1
          while i == 1
            # Message with the current location and simple instructions
            puts "\nFrom: #{location}"
            puts "To:   #{destination}"
            puts "Which files do you want to store in your attic?"
            puts "Type ls for the list of items"
            puts "Select the items by id. Example: 1,3,5"
            input()
        
            file_id = 0
            # If input is "all" all the files and folders will be added to the array
            if @input == "all"
              @bundle_count = "all"
              bundle("1")
              i = 0
            # If input is "ls" all the files and folder will be shown with their IDs
            elsif @input == "ls"
              folder_files.all_files.each do |k|
                puts file_id.to_s + " - " + AtticCleanup::Storage::FolderFiles.find(folder_files.all_files, file_id)
                file_id += 1
              end
            elsif @input == "exit"
              exit 1
            else
              bundle(@input)
              i = 0
            end
          end
        else
          # If option a was selected, all files will be added to the array
          @bundle_count = "all"
          @input = "all"
          bundle(@input)
        end
    
        if f == nil
          i = 1
          # If no items were selected, go back to the input
          if @bundle_count == 0
            puts "\n\nNo file was selected."
            store(nil, nil)
          end
          while i == 1
            # If option f was not selected, you will get a warning before moving the files
            puts "\nAre you sure you want to move #{@bundle_count} files/folders?\n [y/n]"
            input()
            if @input == "y"
              i = 0
            elsif @input == "n"
              exit 1
            else
              puts "y or n?"
            end
          end
        end

        # Moves each file to the MyAttic folder
        @bundle_items.each do |b|
          selected_file = File.join( location, AtticCleanup::Storage::FolderFiles.find(folder_files.all_files, b) )
          # If the file wasn't found, print error
          if AtticCleanup::Storage::FolderFiles.find(folder_files.all_files, b) == nil
            puts "File ID " + b.to_s + " was not found"
          elsif AtticCleanup::Path::Custom.check_ignore(selected_file) == true
            puts "Ignored #{selected_file}"
          else
            # If file was found move it, print it and record it in the log
            puts "Moving " + selected_file + " to your attic.."
            AtticCleanup::Log.save(selected_file, @destination)
            FileUtils.mv(selected_file, @destination)
          end
        end
        puts "The files have been moved to " + @destination
      end
    end
  end
end
