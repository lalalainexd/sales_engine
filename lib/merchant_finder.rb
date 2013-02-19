module MerchantFinder

  def find_by_id(id)
    merchants.find {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    merchants.find {|merchant| merchant.name == name}
  end

  def find_all_by_name(name)
    merchants.find_all {|merchant| merchant.name == name}
  end

end
