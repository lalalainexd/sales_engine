require 'date'
require 'bigdecimal'
require './lib/merchant_finder'


class Merchant
  extend MerchantFinder

  attr_accessor :id, :name, :created_at, :updated_at

  extend MerchantFinder

  def initialize(input)
    @id = input[:id]
    @name = input[:name]

    created_date = input[:created_at]
    @created_at = DateTime.parse(created_date) unless created_date.nil?
    updated_date = input[:updated_at]
    @updated_at = DateTime.parse(updated_date) unless updated_date.nil?
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
    pick_number = merchants.size
    random_number = rand(pick_number)
    random_merchant = merchants[random_number]
    random_merchant
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
    revenue = BigDecimal.new(revenue) / 100
    revenue.to_f
  end

  def self.revenue(date)
    daily_revenue = 0
    merchants.each do |merchant|
      daily_revenue += merchant.revenue(date)*100
    end
    daily_revenue / 100
  end

  def self.most_revenue(x)
    sorted_merchants = merchants.sort {|merchA, merchB| merchB.revenue <=> merchA.revenue}
    sorted_merchants.take x
  end

  def self.most_items(x)
    sorted_merchants = merchants.sort {|merchA, merchB| merchB.total_items_sold <=> merchA.total_items_sold}
    sorted_merchants. take x
  end

  def total_items_sold
    invoices = successful_invoices
    total_items = 0
    invoices.each do |invoice|
      items = invoice.invoice_items
      invoice_total_items = 0
      items.each do |item|
        invoice_total_items += item.quantity
      end
      total_items +=invoice_total_items
    end
    total_items
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
