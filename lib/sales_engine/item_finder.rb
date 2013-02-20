module SalesEngine
  module ItemFinder
    def find_by_id id
      items.find{|item| item.id == id}
    end

    def find_by_name name
      items.find{|item| item.name == name}
    end

    def find_by_description description
      items.find{|item| item.description == description}
    end

    def find_by_unit_price unit_price
      items.find{|item| item.unit_price == unit_price}
    end

    def find_by_merchant_id merchant_id
      items.find{|item| item.merchant_id == merchant_id}
    end

    def find_all_by_name name
      items.find_all{|item|item.name == name}
    end

    def find_all_by_merchant_id merchant_id
      items.find_all{|item|item.merchant_id == merchant_id}
    end

    def find_all_by_unit_price unit_price
      items.find_all{|item|item.unit_price == unit_price}
    end

    def find_all_by_description description
      items.find_all{|item|item.description == description}
    end

    def find_all_by_created_at date
      items.find_all{|invoice| invoice.created_at == date}
    end

    def find_all_by_updated_at date
      items.find_all{|invoice| invoice.updated_at == date}
    end
  end
end
