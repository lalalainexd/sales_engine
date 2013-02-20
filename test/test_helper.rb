require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end

require 'minitest/autorun'
require 'minitest/pride'
require 'date'

require './lib/csv_loader'
require './lib/merchant'
require './lib/transaction'
require './lib/invoice'
require './lib/invoice_item'
require './lib/item'
require './lib/customer'
require './sales_engine'


def clear_all
  Invoice.clear
  Merchant.clear
  Transaction.clear
  InvoiceItem.clear
  Item.clear
  Customer.clear
end

module TestFileLoader
  def load_data_for(*names)
    names.each {|name| CsvLoader.send("load_#{name}","./test/support/#{name}.csv") }
  end
end
