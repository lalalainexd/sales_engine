require 'date'
require 'set'
require './lib/invoice_item'
require './lib/merchant'
require './lib/item_finder'

module SalesEngine
  class Item

    attr_accessor :id,
                  :name,
                  :description,
                  :unit_price,
                  :merchant_id,
                  :created_at,
                  :updated_at

    extend ItemFinder

    def initialize(input)
      @id =input[:id].to_i
      @name = input[:name]
      @description = input[:description]
      @unit_price = input[:unit_price]
      @merchant_id = input[:merchant_id].to_i

      created_date = input[:created_at]
      @created_at = Date.parse(created_date) unless created_date.nil?
      updated_date = input[:updated_at]
      @updated_at = Date.parse(updated_date) unless updated_date.nil?

    end

    def self.items
      @items ||= []
    end

    def self.add(array_of_data)
      items.clear
      array_of_data.each{|item| add_item(item)}
    end

    def self.add_item(item)
      items << item
    end

    def self.size
      items.size
    end

  	def self.clear
  		items.clear unless items.nil?
  	end

    def self.random
      items.sample
    end

    def invoice_items
      InvoiceItem.find_all_by_item_id @id
    end

    def merchant
      Merchant.find_by_id @merchant_id
    end

    def self.most_revenue num_items
      items.sort_by{|item| item.total_revenue}.reverse.take num_items
    end

    def total_revenue
      invoice_items = InvoiceItem.find_all_by_item_id @id
      invoice_items.inject(0) do |rev,invoice_item|
        rev + invoice_item.item_subtotal if invoice_item.success?
      end
    end

    def self.most_items num_items
      items.sort_by{|item| item.total_sold}.reverse.take num_items

    end

    def total_sold
      invoice_items = InvoiceItem.find_all_by_item_id @id
      invoice_items.inject(0) do |total,invoice_item|
        total + invoice_item.quantity if invoice_item.success?
      end
    end

    def best_day
      daily_quantity.max_by do |daily_quantity| 
        daily_quantity.quantity
      end.date.to_date
    end


    def daily_quantity
      invoice_items.collect{|i| DailyItemSales.new self, i.invoice_date}
    end

  end
  
  class DailyItemSales

    attr_reader :date

    def initialize item, date
      @item = item
      @date = date
    end

    def quantity
      invoice_items.inject(0){|quantity, i| quantity + i.quantity}

    end

    def reveneue
      invoice_items.inject(0){|reveneue, i| reveneue + (i.revenue * i.quantity)}
    end

    def invoice_items
      @item.invoice_items.find_all{|i| i.success? && i.invoice_date == @date}
    end

  end
end
