require 'date'
require './lib/transaction_finder'

class Transaction


  attr_accessor :id,
    :invoice_id,
    :credit_card_number,
    :credit_card_expiration_date,
    :result,
    :created_at,
    :updated_at

  extend TransactionFinder

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

  def self.transactions
    @transactions ||= []
  end

  def self.add(array_of_data)
    transactions.clear
    array_of_data.each{|transaction| add_transaction transaction}
  end

  def self.add_transaction transaction
    transactions << transaction
  end

	def self.clear
		transactions.clear unless transactions.nil?
	end

  def self.size
    transactions.size
  end


  def invoice
    Invoice.find_by_id @invoice_id
  end

end
