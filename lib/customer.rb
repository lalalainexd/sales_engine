require 'date'
require 'set'
require './lib/customer_finder'

class Customer

  attr_accessor :id, :first_name, :last_name, :created_at, :updated_at

	extend CustomerFinder

  def initialize(input)
    @id = input[:id]
    @first_name = input[:first_name]
    @last_name = input[:last_name]
    created_date = input[:created_at]
    updated_date = input[:updated_at]
    @created_at = DateTime.parse created_date  unless created_date.nil?
    @updated_at = DateTime.parse updated_date unless updated_date.nil?
  end

	def self.customers
		@customers ||= []
	end

  def self.add(array_of_data)
		customers.clear
		array_of_data.each{|customer| add_customer customer}
  end

	def self.add_customer customer
		customers << customer
	end

  def self.clear
    customers.clear unless customers.nil?
  end

  def self.size
    customers.size
  end

  def self.random
    pick_number = customers.size
    random_number = rand(pick_number)
    random_customer = customers[random_number]
    random_customer
  end


  def invoices
    Invoice.find_all_by_customer_id @id
  end

  def transactions
   invoices.collect{|invoice| invoice.transactions}
  end

  def favorite_merchant
    merchants = invoices.collect do |invoice| 
      Merchant.find_by_id invoice.merchant_id
    end

    merchant_set = merchants & merchants
    merchants = merchant_set.sort_by do |merchant|
      successful_invoices_with_merchant merchant.id
    end

    merchants.last
  end

  def successful_invoices_with_merchant merchant_id
    invoices.count do |invoice|
      invoice.success? && invoice.merchant_id == merchant_id
    end
  end

end
