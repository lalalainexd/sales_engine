module InvoiceFinder

  def find_by_id id
    invoices.find{|invoice| invoice.id == id}
  end

  def find_by_customer_id customer_id
    invoices.find{|invoice| invoice.customer_id == customer_id}
  end

  def find_by_merchant_id merchant_id
    invoices.find{|invoice| invoice.merchant_id == merchant_id}
  end

  def find_by_status status
    invoices.find{|invoice| invoice.status == status}
  end

  def find_by_created_at date
    invoices.find{|invoice| invoice.created_at == date}
  end

  def find_by_updated_at date
    invoices.find{|invoice| invoice.updated_at == date}
  end

  def find_all_by_customer_id customer_id
    invoices.find_all{|invoice| invoice.customer_id == customer_id}
  end

  def find_all_by_merchant_id merchant_id
    invoices.find_all{|invoice| invoice.merchant_id == merchant_id}
  end

  def find_all_by_created_at date
    invoices.find_all{|invoice| invoice.created_at == date}
  end

  def find_all_by_updated_at date
    invoices.find_all{|invoice| invoice.updated_at == date}
  end
end
