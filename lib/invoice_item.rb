require 'date'
class InvoiceItem

  attr_accessor :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

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
    @@invoice_item = array_of_data
  end

  def self.size
    @@invoice_item.size
  end

end