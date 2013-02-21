require 'simplecov'

SimpleCov.start do
  add_filter "test"
end

require 'minitest/autorun'
require 'minitest/pride'

require 'sales_engine'

module SalesEngine
  module TestFileLoader
    def load_data_for(*names)
      names.each {|name| CsvLoader.send("load_#{name}","./test/support/#{name}.csv") }
    end

    def clear_all
      Invoice.clear
      Merchant.clear
      Transaction.clear
      InvoiceItem.clear
      Item.clear
      Customer.clear
    end
  end
end
