module SalesEngine
  module TransactionFinder

    def random
      transactions.sample
    end

    def find_by_id id
      transactions.find {|transaction| transaction.id == id}
    end

    def find_all_by_invoice_id(id)
      transactions.find_all {|transaction| transaction.invoice_id == id}
    end

    def find_by_credit_card_number card_number
      transactions.find{|t| t.credit_card_number == card_number}
    end

    def find_all_by_result result
      transactions.find_all{|t| t.result == result}
    end

  end
end
