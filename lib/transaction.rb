require 'date'

class Transaction

  attr_accessor :id,
    :invoice_id,
    :credit_card_number,
    :credit_card_expiration_date,
    :result,
    :created_at,
    :updated_at

  def initialize(input)
    @id = input[:id]
    @invoice_id = input[:invoice_id]
    @credit_card_number = input[:credit_card_number]
    @credit_card_expiration_date = input[:credit_card_expiration_date]
    @result = input[:result]

    created_date = input[:created_at]
    @created_at = DateTime.parse(created_date) unless created_date.nil?
    updated_date = input[:updated_at]
    @updated_at = DateTime.parse(updated_date) unless updated_date.nil?
  end


  def self.add(array_of_data)
    @@transactions = array_of_data
  end

  def self.size
    @@transactions.size
  end

  def self.find_all_by_invoice_id(id)
    @@transactions.find_all {|transaction| transaction.invoice_id == id}
  end
end
