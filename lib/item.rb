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

end