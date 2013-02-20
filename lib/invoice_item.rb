require 'date'
require './lib/item'
require './lib/invoice'
require './lib/invoice_item_finder'

module SalesEngine
  class InvoiceItem

    attr_accessor :id,
      :item_id,
      :invoice_id,
      :quantity,
      :unit_price,
      :created_at,
      :updated_at

    extend InvoiceItemFinder

    def initialize(input)
      @id =input[:id].to_i
      @item_id = input[:item_id].to_i
      @invoice_id = input[:invoice_id].to_i
      @quantity = input[:quantity].to_i unless input[:quantity].nil?
      @unit_price = input[:unit_price].to_i unless input[:unit_price].nil?

      created_date = input[:created_at]
      @created_at = clean_date created_date unless created_date.nil?

      updated_date = input[:updated_at]
      @updated_at = clean_date updated_date unless updated_date.nil?
    end

    def clean_date date
      if date.class == String
        date = Date.parse date
      end
      date
    end

    def self.invoice_items
      @invoice_items ||= []
    end

    def self.add(array_of_data)
      invoice_items.clear
      array_of_data.each{|invoice_item| add_invoice_item invoice_item}
    end

    def self.add_invoice_item invoice_item
      invoice_items << invoice_item
    end

    def self.size
      invoice_items.size
    end

    def self.clear
      invoice_items.clear unless invoice_items.nil?
    end

    def invoice
      Invoice.find_by_id(@invoice_id)
    end

    def item
      Item.find_by_id(@item_id)
    end

    def self.create input
      id = get_next_id
      item_id = input[:item].id
      invoice_id = input[:invoice].id
      quantity = input[:quantity]
      unit_price = input[:item].unit_price

      add_invoice_item InvoiceItem.new id: id,
        item_id: item_id,
        invoice_id: invoice_id,
        quantity: quantity,
        unit_price: unit_price,
        created_at: Date.today,
        updated_at: Date.today
    end

    def self.get_next_id
      get_last_id + 1 
    end

    def self.get_last_id
      invoice_items.empty? ? 0 : invoice_items.max_by{|invoice| invoice.id}.id
    end

    def item_subtotal
      @item_subtotal ||= @quantity * @unit_price
    end

    def success?
      invoice.success?
    end

    def invoice_date
      invoice.created_at
    end
  end
end
