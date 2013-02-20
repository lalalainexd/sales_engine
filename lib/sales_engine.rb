require './lib/sales_engine/csv_loader'
require './lib/sales_engine/merchant'
require './lib/sales_engine/transaction'
require './lib/sales_engine/invoice'
require './lib/sales_engine/invoice_item'
require './lib/sales_engine/item'
require './lib/sales_engine/customer'

module SalesEngine
  class SalesEngine

    def self.startup
      CsvLoader.load_data
    end
  end
end
