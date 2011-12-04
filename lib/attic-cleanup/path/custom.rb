module AtticCleanup
  module Path
    class Custom
      attr_accessor :name, :path, :file, :line_nr
      
      # Gets the last line in the default_path.txt file, 
      # which is the path to the default route
      def self.default
        File.open(MyAttic::DEFAULT, 'r') do |r|
          line_array = []
          while line = r.gets do
            line_array << line
          end
          line_array.last
        end
      end
      
      # Selects every line from the selected file
      # but ignores lines where the first character is '#'
      def self.all(file)
        File.open(file, 'r') do |r|
          line_array = []
          while line = r.gets do
            if line[0..0] == "#"
            else
              line_array << line
            end
          end
          line_array
        end
      end
    
      # Gets a specific line from a file
      def find_line
        File.open(@file, 'r') do |r|
          k = []
          k[0] = nil
          while line = r.gets do
            k << line
          end
          if k[@line_nr] == nil
           "This line does not exist."
          elsif k[@line_nr] == "\n"
            "Empty"
          else
            k[@line_nr]
          end
        end
      end
      
      # Gets the custom shortcuts and looks in the custom_paths.txt file
      # if there is a match. If there is it will select that line and
      # extract the shortcut, so only the path remains
      def find_custom
        File.open(@file, 'r') do |r|
          k = []
          k[0] = nil
          while line = r.gets do
            name_count = @name.count("A-z, \s")
            k << line[0..name_count]
            this_name = k.last
            
            if this_name == @name+" "
              selected_line = line
              the_name = this_name
            end
          end
          if selected_line == nil
            puts "Shortcut not found"
            exit 1
          else
            the_name_count = the_name.count("A-z, \s")
            line_count = selected_line.count("A-z, \s, '/'")
            selected_line[the_name_count..line_count-1]
          end
        end
      end

      # Write to the custom_paths.txt file
      def write
        File.open(@file, 'a') do |w| 
          w.write("\n"+ @name + " " + @path)
        end
      end
      
      def self.default(value)
        File.open(MyAttic::DEFAULT, 'w') do |w| 
          w.write("#Write your default location here.\n#{value}")
        end
      end
    end
  end
end
