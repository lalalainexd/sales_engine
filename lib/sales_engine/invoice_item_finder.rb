module SalesEngine
  module InvoiceItemFinder

    def find_by_id(id)
      invoice_items.find {|invoice_item| invoice_item.id == id}
    end

    def find_all_by_item_id(item_id)
      invoice_items.find_all {|invoice_item| invoice_item.item_id == item_id}
    end

    def find_all_by_invoice_id(invoice_id)
       invoice_items.find_all do |invoice_item|
        invoice_item.invoice_id == invoice_id
      end
    end

    def find_all_by_created_at(date)
      invoice_items.find_all do |invoice_item|
        invoice_item.created_at.to_date == date
      end
    end
  end
end
