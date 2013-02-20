require './test/test_helper'

module SalesEngine

  class MerchantTest < MiniTest::Unit::TestCase
    include TestFileLoader

    def setup
      load_data_for(:merchants)
    end

    def teardown
      clear_all
    end

    def test_it_exists
      merchant = Merchant.new({})
      assert_kind_of Merchant, merchant
    end

    def assert_merchant_is_correctly_defined(merchant,params)
      assert_equal params[:id].to_i , merchant.id
      assert_equal params[:name], merchant.name
      assert_equal Date.parse(params[:created_at]), merchant.created_at
      assert_equal Date.parse(params[:updated_at]), merchant.updated_at
    end

    def test_it_is_initialized_from_a_hash_of_data
      params_1 = { id: '1', name: 'name', created_at: '2012-03-27 14:53:59 UTC',
        updated_at: '2012-03-27 14:53:59 UTC'
      }
      merchant = Merchant.new(params_1)
      assert_merchant_is_correctly_defined(merchant, params_1)

      params_2 = {id: '2', name: 'name2', created_at: '2012-03-28 14:53:59 UTC',
        updated_at: '2012-03-28 14:53:59 UTC'
      }
      merchant = Merchant.new(params_2)
      assert_merchant_is_correctly_defined(merchant, params_2)
    end

    def test_it_stores_merchants_from_an_array
      data = [Merchant.new(id: '1', name: 'name')]
      Merchant.add data
      assert_equal 1, Merchant.size
    end

    def test_it_returns_a_random_merchant_when_random_is_called
      result1 = Merchant.random
      result2 = Merchant.random

      refute_equal result1, result2
    end

    def test_it_finds_a_merchant_by_id
      merchant = Merchant.find_by_id(10)
      assert_equal 10, merchant.id
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
      load_data_for(:items)
      merchant = Merchant.find_by_id(1)
      assert_equal 8 , merchant.items.size
    end

    def test_it_returns_a_merchants_associated_invoices
      load_data_for(:invoices)
      merchant = Merchant.find_by_id(1)
      assert_equal 1 , merchant.invoices.size
    end
  end

end
