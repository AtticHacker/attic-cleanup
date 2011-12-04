module AtticCleanup
  module Storage
    class FolderFiles
      
      def all_files
        @all_files
      end
      
      # Select all files from the selected folder
      def all_files= ( value )
        Dir.chdir(value)
        @all_files = Dir.glob("*");
      end
      
      # Find the file by it's ID
      def self.find(files, number)
        current_files = []
        file_id = 0
          files.each do |f|
          current_files[file_id] = f
          file_id += 1
        end
        current_files[number]
      end
    end
  end
end
