require 'date'
require './lib/invoice_finder'


class Invoice

  attr_accessor :id,
    :customer_id,
    :merchant_id,
    :status,
    :created_at,
    :updated_at

	extend InvoiceFinder

  def initialize(input)
    @id = input[:id]
    @customer_id = input[:customer_id]
    @merchant_id = input[:merchant_id]
    @status = input[:status]

    created_date = input[:created_at]
    @created_at = DateTime.parse(created_date) unless created_date.nil?

    updated_date = input[:updated_at]
    @updated_at = DateTime.parse(updated_date) unless updated_date.nil?
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
    invoice_items.inject([]){|items, invoice_item| items << Item.find_by_id(invoice_item.item_id)}
  end

  def success?
    transactions = Transaction.find_all_by_invoice_id(@id)
    transactions.any?{|transaction| transaction.result == 'success'}
  end

  def subtotal
    @invoice_subtotal = 0
    invoice_items.each do |item|
      item_subtotal = item.quantity.to_i * item.unit_price.to_i
      @invoice_subtotal += item_subtotal
    end
    @invoice_subtotal
  end


end

