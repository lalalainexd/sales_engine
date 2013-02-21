require 'date'
require 'sales_engine/invoice_finder'

module SalesEngine
class Invoice

  attr_accessor :id,
    :customer_id,
    :merchant_id,
    :status,
    :created_at,
    :updated_at

  extend InvoiceFinder

  def initialize(input)

    @id = input[:id].nil? ? Invoice.get_next_id : input[:id].to_i

    @customer_id = input[:customer_id].to_i
    @merchant_id = input[:merchant_id].to_i
    @status = input[:status]

    created_date = input[:created_at]
    @created_at = created_date.nil? ? Date.today : clean_date(created_date)

    updated_date = input[:updated_at]
    @updated_at = updated_date.nil? ? Date.today : clean_date(updated_date)

  end

  def clean_date date
    Date.parse date

  end

  def self.invoices
    @invoices ||= []
  end


  def self.add(array_of_data)
    invoices.clear
    array_of_data.each{|invoice| add_invoice invoice}
  end

  def self.add_invoice invoice
    invoices << invoice
  end

  def self.clear
    invoices.clear unless invoices.nil?
  end

  def self.size
    invoices.size
  end

  def self.random
    invoices.sample
  end

  def customer
    Customer.find_by_id @customer_id
  end

  def transactions
    Transaction.find_all_by_invoice_id @id
  end

  def invoice_items
    InvoiceItem.find_all_by_invoice_id @id
  end

  def items
    invoice_items.inject([]) do |items, invoice_item|
      items <<  invoice_item.item
    end
  end

  def success?
    transactions = Transaction.find_all_by_invoice_id(@id)
    transactions.any?{|transaction| transaction.result == 'success'}
  end

  def pending?
    transactions.all? {|transaction| transaction.result == 'failed'}
  end

  def subtotal
    @invoice_subtotal ||= invoice_items.inject(0) do |sum, item|
      sum += item.item_subtotal
    end
  end

  def self.create input
    input[:customer_id] = input[:customer].id
    input[:merchant_id] = input[:merchant].id

    invoice = Invoice.new input

    Invoice.add_invoice invoice

    create_invoice_items count_unique(input[:items]), invoice
    @invoice_subtotal = nil
    return invoice
  end

  def self.create_invoice_items items, invoice
    items.each do |(item, quantity)|
      InvoiceItem.create item: item, quantity: quantity, invoice: invoice
    end
  end

  def self.count_unique items
    items.each_with_object(Hash.new(0)) do
      |item, hash| hash[item] += 1
    end
  end

  def self.get_next_id
    invoices.max_by{|invoice| invoice.id}.id + 1
  end

  def charge input
    input[:invoice_id] = @id
    Transaction.create input

  end

  def count_items_on_invoice
    invoice_items.inject(0) {|sum, invoice_item| sum + invoice_item.quantity}
  end

end
end
