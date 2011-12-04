module AtticCleanup
  module Log
    def self.save(file, destination)
      File.open(MyAttic::LOG, "a") do |w|
        w.write(file +" >> "+ destination + " || Date: " + Time.now.to_s + "\n")
      end
    end
  end
end
