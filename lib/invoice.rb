require 'date'
class Invoice

  @@invoices = nil

  attr_accessor :id,
    :customer_id,
    :merchant_id,
    :status,
    :created_at,
    :updated_at

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


  def self.add(array_of_data)
    @@invoices = array_of_data
  end

  def self.clear
    @@invoices.clear unless @@invoices.nil?
  end

  def self.size
    @@invoices.size
  end

  def self.random
  @@invoices.sample
  end

  def self.find_by_id id
    @@invoices.find{|invoice| invoice.id == id}
  end

  def self.find_by_customer_id customer_id
    @@invoices.find{|invoice| invoice.customer_id == customer_id}
  end

  def self.find_by_merchant_id merchant_id
    @@invoices.find{|invoice| invoice.merchant_id == merchant_id}
  end

  def self.find_by_status status
    @@invoices.find{|invoice| invoice.status == status}
  end

  def self.find_by_created_at date
    @@invoices.find{|invoice| invoice.created_at == date}
  end

  def self.find_by_updated_at date
    @@invoices.find{|invoice| invoice.updated_at == date}
  end

  def self.find_all_by_customer_id customer_id
    @@invoices.find_all{|invoice| invoice.customer_id == customer_id}
  end

  def self.find_all_by_merchant_id merchant_id
    @@invoices.find_all{|invoice| invoice.merchant_id == merchant_id}
  end

  def self.find_all_by_created_at date
    @@invoices.find_all{|invoice| invoice.created_at == date}
  end

  def self.find_all_by_updated_at date
    @@invoices.find_all{|invoice| invoice.updated_at == date}
  end

  def customer
    Customer.find_by_id @customer_id
  end

  def transactions
    Transaction.find_all_by_invoice_id @id
  end
end

