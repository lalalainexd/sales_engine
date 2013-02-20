require 'date'
require 'set'
require 'sales_engine/customer_finder'

module SalesEngine
  class Customer

    attr_accessor :id, :first_name, :last_name, :created_at, :updated_at

    extend CustomerFinder

    def initialize(input)
      @id = input[:id].to_i
      @first_name = input[:first_name]
      @last_name = input[:last_name]
      created_date = input[:created_at]
      updated_date = input[:updated_at]
      @created_at = Date.parse created_date  unless created_date.nil?
      @updated_at = Date.parse updated_date unless updated_date.nil?
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
      customers.sample
    end

    def invoices
      Invoice.find_all_by_customer_id @id
    end

    def transactions
      invoices.collect{|invoice| invoice.transactions}
    end

    def merchants
      invoices.inject(Set.new) do |set, invoice|
        set.add Merchant.find_by_id invoice.merchant_id
      end
    end

    def favorite_merchant
      merchants.max_by do |merchant|
        successful_invoices_with_merchant_count merchant.id
      end

    end

    def successful_invoices_with_merchant_count merchant_id
      invoices.count do |invoice|
        invoice.success? && invoice.merchant_id == merchant_id
      end
    end

  end
end
