class Item

attr_accessor :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

  def initialize(input)
    @id =input[:id]
    @name = input[:name]
    @description = input[:description]
    @unit_price = input[:unit_price]
    @merchant_id = input[:merchant_id]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
  end

  def self.add(array_of_data)
    @@items = array_of_data
  end

  def self.size
    @@items.size
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
end