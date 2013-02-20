require 'date'
require './lib/transaction_finder'

module SalesEngine
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
      @id = input[:id].to_i
      @invoice_id = input[:invoice_id].to_i
      @credit_card_number = input[:credit_card_number]
      @credit_card_expiration_date = input[:credit_card_expiration_date]
      @result = input[:result]

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

    def self.create input
      input[:created_at] = Date.today
      input[:update_at] = input[:created_at]
      input[:id] = get_next_id

      transaction = Transaction.new input
      add_transaction transaction

      return transaction

    end

    def self.get_next_id
      if transactions.empty?
        id = 1
      else
        id = transactions.max_by{|transaction| transaction.id.to_i}.id.to_i + 1
        id.to_s
      end
    end

  end
end
