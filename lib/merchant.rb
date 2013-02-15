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
end