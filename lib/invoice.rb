
class Invoice

  attr_accessor :id,
    :customer_id,
    :merchant_id,
    :status,
    :created_at,
    :updated_at

  def initialize(input)
    @id = input[:id]
    @customer_id = input[:customer_id]
    @merchant_id = input[:merchant_id]
    @status = input[:status]
    @created_at = input[:created_at]
    @updated_at = input[:updated_at]
  end


  def self.add(array_of_data)
    @@invoices = array_of_data
  end

  def self.size
    @@invoices.size
  end

  def self.random
  @@invoices.sample
  end

  def self.find_by_id id
    @@invoices.find{|invoice| invoice.id == id}
  end

  def self.find_by_customer_id customer_id
    @@invoices.find{|invoice| invoice.customer_id == customer_id}
  end

  def self.find_by_merchant_id merchant_id
    @@invoices.find{|invoice| invoice.merchant_id == merchant_id}
  end

  def self.find_by_status status
    @@invoices.find{|invoice| invoice.status == status}
  end

  def self.find_by_created_at date
    @@invoices.find{|invoice| invoice.created_at == date}
  end
end
