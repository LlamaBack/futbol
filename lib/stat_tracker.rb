require 'csv'

class StatTracker

  def self.from_csv(locations)
    locations.each do |name, path|
      puts "#{name}: #{path}"
      CSV.read(path, headers: true).each do |row|
        pp row.to_h
      end
      puts "\n"
    end
  end
end
