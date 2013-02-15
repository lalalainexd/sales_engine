require 'date'
require './lib/invoice_item'
require './lib/merchant'

class Item

  @@items = nil

  attr_accessor :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

  def initialize(input)
    @id =input[:id]
    @name = input[:name]
    @description = input[:description]
    @unit_price = input[:unit_price]
    @merchant_id = input[:merchant_id]

    created_date = input[:created_at]
    @created_at = DateTime.parse(created_date) unless created_date.nil?
    updated_date = input[:updated_at]
    @updated_at = DateTime.parse(updated_date) unless updated_date.nil?

    #parse dates in date or datetime, whichever it is
  end

  def self.add(array_of_data)
    @@items = array_of_data
  end

  def self.size
    @@items.size
  end

	def self.clear
		@@items.clear unless @@items.nil?
	end

  def self.random
    @@items.sample
  end

  def self.find_by_id id
    @@items.find{|item| item.id == id}
  end

  def self.find_by_name name
    @@items.find{|item| item.name == name}
  end

  def self.find_by_description description
    @@items.find{|item| item.description == description}
  end

  def self.find_by_unit_price unit_price
    @@items.find{|item| item.unit_price == unit_price}
  end

  def self.find_by_merchant_id merchant_id
    @@items.find{|item| item.merchant_id == merchant_id}
  end

  def self.find_all_by_name name
    @@items.find_all{|item|item.name == name}
  end

  def self.find_all_by_merchant_id merchant_id
    @@items.find_all{|item|item.merchant_id == merchant_id}
  end

  def self.find_all_by_unit_price unit_price
    @@items.find_all{|item|item.unit_price == unit_price}
  end

  def self.find_all_by_description description
    @@items.find_all{|item|item.description == description}
  end

  def self.find_all_by_created_at date
    @@items.find_all{|invoice| invoice.created_at == date}
  end

  def self.find_all_by_updated_at date
    @@items.find_all{|invoice| invoice.updated_at == date}
  end

  def invoice_items
    InvoiceItem.find_all_by_item_id @id
  end

  def merchant
    Merchant.find_by_id @merchant_id
  end

  def self.most_revenue num_items
    @@items.sort_by{|item| item.total_revenue}.reverse.take num_items

  end

  def total_revenue
    invoice_items = InvoiceItem.find_all_by_item_id @id
    invoice_items.inject(0) do |rev,invoice_item|
      rev + invoice_item.quantity * invoice_item.unit_price if invoice_item.invoice.success?
    end
  end

  def self.most_items num_items
    @@items.sort_by{|item| item.total_sold}.reverse.take num_items

  end

  def total_sold
    invoice_items = InvoiceItem.find_all_by_item_id @id
    invoice_items.inject(0) do |total,invoice_item|
      total + invoice_item.quantity if invoice_item.invoice.success?
    end
  end
end