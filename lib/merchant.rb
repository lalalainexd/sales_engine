require 'date'
require 'bigdecimal'
require './lib/merchant_finder'

module SalesEngine
  class Merchant
    extend MerchantFinder

    attr_accessor :id, :name, :created_at, :updated_at

    extend MerchantFinder

    def initialize(input)
      @id = input[:id].to_i
      @name = input[:name]
      created_date = input[:created_at]
      @created_at = Date.parse(created_date) unless created_date.nil?
      updated_date = input[:updated_at]
      @updated_at = Date.parse(updated_date) unless updated_date.nil?
    end

    def self.merchants
      @merchants ||=[]
    end

    def self.add(array_of_data)
      merchants.clear
      array_of_data.each{|merchant| add_merchant(merchant)}
    end

    def self.add_merchant(merchant)
      merchants << merchant
    end

    def self.clear
      merchants.clear unless merchants.nil?
    end

    def self.size
      merchants.size
    end

    def self.random
      merchants.sample
    end

    def items
      Item.find_all_by_merchant_id(@id)
    end

    def invoices
      Invoice.find_all_by_merchant_id @id
    end

    def successful_invoices
      invoices.find_all { |invoice| invoice.success? == true }
    end

    def successful_invoices_for_a_(date)
      successful_invoices.find_all {|invoice| invoice.created_at == date}
    end

    def revenue(date = nil)
      invcs = date.nil? ? successful_invoices : successful_invoices_for_a_(date)
      calculate_revenue_for(invcs)
    end

    def calculate_revenue_for(invoices)
      revenue = invoices.inject(0) do |sum, invoice|
        sum + invoice.subtotal
      end
      (BigDecimal.new(revenue) / 100).to_f
    end

    def self.revenue(date)
      daily_rev = merchants.inject(0) do |revenue, merchant|
        revenue + merchant.revenue(date)*100
      end
        daily_rev/100
    end

    def self.most_revenue(x)
      merchants_with_revenue = merchants.each_with_object({}) do |merchant, hsh|
        hsh[merchant.id] = merchant.revenue
      end.sort {|(id_a, rev_a), (id_b, rev_b)| rev_b <=> rev_a }.take(x)

      merchants_with_revenue.map do |arr|
        self.find_by_id(arr[0])
      end
    end

    def self.most_items(x)
      merchants_with_items = merchants.each_with_object({}) do |merchant, hsh|
        hsh[merchant.id] = merchant.total_items_sold
      end.sort {|(id_a, items_a),(id_b, items_b)| items_b <=> items_a }.take(x)

      merchants_with_items.map do |arr|
        self.find_by_id(arr[0])
      end
    end

    def total_items_sold
      successful_invoices.inject(0) do |sum, invoice| 
        sum + invoice.count_items_on_invoice
      end
    end

    def customers_with_pending_invoices
      invoices.find_all {|invoice| invoice.success? == false}
    end

    def favorite_customer
      custs = invoices.collect do |invoice|
        Customer.find_by_id invoice.customer_id
      end
      customer_set = custs & custs
      customers = customer_set.sort_by do |customer|
        successful_invoices_with_customer(customer.id)
      end
      customers.last
    end

    def successful_invoices_with_customer(customer_id)
      invoices.count do |invoice|
        invoice.success? && invoice.customer_id == customer_id
      end
    end
  end
end
