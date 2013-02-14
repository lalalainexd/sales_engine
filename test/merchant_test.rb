require './test/test_helper'

class MerchantTest < MiniTest::Unit::TestCase

  def setup
    CsvLoader.load_merchants('./test/support/merchants.csv')
  end
  def test_it_exists
    merchant = Merchant.new({})
    assert_kind_of Merchant, merchant
  end

  def test_it_is_initialized_from_a_hash_of_data
    merchant = Merchant.new(
      id: 'id',
      name: 'name',
      created_at: '2012-03-27 14:53:59 UTC',
      updated_at: '2012-03-27 14:53:59 UTC'
    )

    date = DateTime.parse '2012-03-27 14:53:59 UTC'
    assert_equal 'id', merchant.id
    assert_equal 'name', merchant.name
    assert_equal date, merchant.created_at
    assert_equal date, merchant.updated_at

    merchant = Merchant.new(
      id: 'id2',
      name: 'name2',
      created_at: '2012-03-28 14:53:59 UTC',
      updated_at: '2012-03-28 14:53:59 UTC'
    )
    date = DateTime.parse '2012-03-28 14:53:59 UTC'

    assert_equal 'id2', merchant.id
    assert_equal 'name2', merchant.name
    assert_equal date, merchant.created_at
    assert_equal date, merchant.updated_at
  end

  def test_it_stores_merchants_from_an_array
    data = [Merchant.new(
      id: 'id',
      name: 'name',
    )]
    Merchant.add data
    assert_equal 1, Merchant.size
  end

  def test_it_returns_a_random_merchant_when_random_is_called
    random_merchant1 = Merchant.random
    assert_kind_of Merchant, random_merchant1
    #can i do a compare assert?
  end

  def test_it_finds_a_merchant_by_id
    merchant = Merchant.find_by_id("10")
    assert_equal "10", merchant.id
  end

  def test_if_returns_a_merchant_by_name
    found_merchant = Merchant.find_by_name("Cummings-Thiel")
    assert_equal "Cummings-Thiel", found_merchant.name
  end

  def test_it_returns_all_merchants_by_name
    found_merchants = Merchant.find_all_by_name("Williamson Group")
    assert_equal 2, found_merchants.length
  end

  def test_it_returns_a_merchants_items_for_sale
    merchant = Merchant.find_by_id("1")
    assert_equal 8 , merchant.items.size
  end

  def test_it_returns_a_merchants_associated_invoices
    merchant = Merchant.find_by_id("1")
    assert_equal 1 , merchant.invoices.size
  end

end