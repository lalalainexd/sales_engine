require 'date'
require './lib/item'
require './lib/invoice'

class InvoiceItem

  @@invoice_items = nil

  attr_accessor :id,
    :item_id,
    :invoice_id,
    :quantity,
    :unit_price,
    :created_at,
    :updated_at

  def initialize(input)
    @id =input[:id]
    @item_id = input[:item_id]
    @invoice_id = input[:invoice_id]
    @quantity = input[:quantity]
    @unit_price = input[:unit_price]

    created_date = input[:created_at]
    @created_at = DateTime.parse(created_date) unless created_date.nil?

    updated_date = input[:updated_at]
    @updated_at = DateTime.parse(updated_date) unless updated_date.nil?
  end

  def self.add(array_of_data)
    @@invoice_items = array_of_data
  end

  def self.size
    @@invoice_items.size
  end

  def self.clear
    @@invoice_items.clear unless @@invoice_items.nil?
  end

  def self.find_by_id(id)
    @@invoice_items.find {|invoice_item| invoice_item.id == id}
  end

  def self.find_all_by_item_id(item_id)
    @@invoice_items.find_all {|invoice_item| invoice_item.item_id == item_id}
  end

  def self.find_all_by_invoice_id(invoice_id)
     @@invoice_items.find_all {|invoice_item| invoice_item.invoice_id == invoice_id}
  end

  def invoice
    Invoice.find_by_id(@invoice_id)
  end
  
  def item
    Item.find_by_id(@item_id)
  end
end