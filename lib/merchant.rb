require 'date'
require './lib/item'
require "./lib/invoice"
class Merchant

  @@merchants = nil

  attr_accessor :id, :name, :created_at, :updated_at

  def initialize(input)
    @id = input[:id]
    @name = input[:name]

    created_date = input[:created_at]
    @created_at = DateTime.parse(created_date) unless created_date.nil?
    updated_date = input[:updated_at]
    @updated_at = DateTime.parse(updated_date) unless updated_date.nil?
  end

  def self.add(array_of_data)
    @@merchants = array_of_data
  end

  def self.clear
    @@merchants.clear unless @@merchants.nil?
  end

  def self.size
    @@merchants.size
  end

  def self.random
    pick_number = @@merchants.size
    random_number = rand(pick_number)
    random_merchant = @@merchants[random_number]
    random_merchant
  end

  def self.find_by_id(id)
    @@merchants.find {|merchant| merchant.id == id}
  end

  def self.find_by_name(name)
    @@merchants.find {|merchant| merchant.name == name}
  end

  def self.find_all_by_name(name)
    @@merchants.find_all {|merchant| merchant.name == name}
  end

  def items
    Item.find_all_by_merchant_id(@id)
  end

  def invoices
    Invoice.find_all_by_merchant_id @id
  end

  def successful_invoices
    invoices.find_all {|invoice| invoice.success? == true}
  end

  def revenue(date = nil)
    if date.nil?
      invoices = successful_invoices
    else
      invoices = successful_invoices.find_all {|invoice| invoice.created_at.to_date == date}
    end
    revenue = 0
    invoices.each do |invoice|
      revenue += invoice.subtotal
    end
    revenue
  end

  def self.revenue(date)
    daily_revenue = 0
    @@merchants.each do |merchant|
      daily_revenue += merchant.revenue(date)
    end
    daily_revenue
  end

  def self.most_revenue(x)
    sorted_merchants = @@merchants.sort {|merchA, merchB| merchB.revenue <=> merchA.revenue}
    sorted_merchants.take x
  end

  def customers_with_pending_invoices
    invoices.find_all {|invoice| invoice.success? == false}
  end

  def favorite_customer
    customers = invoices.collect{|invoice| Customer.find_by_id invoice.customer_id}
    customer_set = customers & customers
    customers = customer_set.sort_by {|customer| successful_invoices_with_customer customer.id}

    customers.last
    end
  def successful_invoices_with_customer customer_id
    invoices.count{|invoice| invoice.success? && invoice.customer_id == customer_id}
  end
end
