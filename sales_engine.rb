require 'csv_loader'

module SalesEngine
  class SalesEngine

    def self.startup
      CsvLoader.load_data
    end
  end
end
