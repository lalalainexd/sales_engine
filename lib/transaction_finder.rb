module TransactionFinder

  def find_by_id id
    transactions.find {|transaction| transaction.id == id}
  end

  def find_all_by_invoice_id(id)
    transactions.find_all {|transaction| transaction.invoice_id == id}
  end

end
