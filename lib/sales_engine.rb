require 'sales_engine/csv_loader'
require 'sales_engine/merchant'
require 'sales_engine/transaction'
require 'sales_engine/invoice'
require 'sales_engine/invoice_item'
require 'sales_engine/item'
require 'sales_engine/customer'

module SalesEngine

    def self.startup
      CsvLoader.load_data
    end
end
