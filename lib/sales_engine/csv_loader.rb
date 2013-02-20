require 'csv'
module SalesEngine
  class CsvLoader

    def self.load_data
      load_merchants
      load_invoice_items
      load_items
      load_transactions
      load_invoices
      load_customers
    end

    def self.parse filename
      CSV.open(filename, headers: true, header_converters: :symbol)
    end

    def self.load_merchants(filepath = './data/merchants.csv')
      contents = parse(filepath)
      merchants = contents.collect { |row| Merchant.new(row.to_hash) }
      Merchant.add merchants
    end


    def self.load_invoice_items(filepath = './data/invoice_items.csv')
      contents = parse (filepath)
      invoice_items = contents.collect { |row| InvoiceItem.new(row.to_hash) }
      InvoiceItem.add invoice_items
    end

    def self.load_items(filepath = './data/items.csv')
      contents = parse(filepath)
      items = contents.collect { |row| Item.new(row.to_hash) }
      Item.add items
    end

    def self.load_transactions(filepath = './data/transactions.csv')
      contents = parse(filepath)
      transactions = contents.collect { |row| Transaction.new(row.to_hash) }
      Transaction.add transactions
    end

    def self.load_invoices(filepath = './data/invoices.csv')
      contents = parse(filepath)
      invoice = contents.collect { |row| Invoice.new(row.to_hash) }
      Invoice.add invoice
    end

    def self.load_customers(filepath = './data/customers.csv')
      contents = parse(filepath)
      customers = contents.collect { |row| Customer.new(row.to_hash) }
      Customer.add customers
    end
  end
end
