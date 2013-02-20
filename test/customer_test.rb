require './test/test_helper'

module SalesEngine

  class CustomerTest < MiniTest::Unit::TestCase

    include TestFileLoader

    def teardown
      clear_all
    end


    def test_it_returns_invoices_associated_with_a_customer
      load_data_for :customers
      load_data_for :invoices

      customer = Customer.find_by_id(1)
      assert_equal 8 , customer.invoices.size
    end

    def test_it_returns_transactions_associated_with_the_customer
      CsvLoader.load_customers
      CsvLoader.load_invoices
      CsvLoader.load_transactions

      customer = Customer.find_by_id(2)
      assert_equal 1, customer.transactions.size
    end

    def test_it_returns_the_customers_favorite_merchant
      CsvLoader.load_customers #loading real data instead
      CsvLoader.load_invoices
      CsvLoader.load_transactions
      CsvLoader.load_merchants

      customer = Customer.find_by_id(2)
      merchant = Merchant.find_by_name 'Shields, Hirthe and Smith'
      assert_equal merchant, customer.favorite_merchant
    end
  end

  # Tests the class methods of Customer
  class CustomerClassTest < MiniTest::Unit::TestCase
    include TestFileLoader

    def setup
      load_data_for :customers
    end

    def teardown
      clear_all
    end

    def test_it_exists
      customer = Customer.new({})
      assert_kind_of Customer, customer
    end

    def assert_valid_customer params, customer

      assert_equal params[:id].to_i, customer.id
      assert_equal params[:first_name], customer.first_name
      assert_equal params[:last_name], customer.last_name
      assert_equal Date.parse(params[:created_at]), customer.created_at
      assert_equal Date.parse(params[:updated_at]), customer.updated_at

    end

    def test_it_is_initialized_from_a_hash_of_data
      params1 = {id: '1',
        first_name: 'first_name',
        last_name: 'last_name',
        created_at: '2012-03-27 14:54:09 UTC',
        updated_at: '2012-03-27 14:54:09 UTC' }

      params2 = { id: '2',
        first_name: 'first_name2',
        last_name: 'last_name2',
        created_at: '2012-03-28 14:54:09 UTC',
        updated_at: '2012-03-29 14:54:09 UTC' }

      assert_valid_customer params1, Customer.new(params1)
      assert_valid_customer params2, Customer.new(params2)

    end

    def test_it_stores_customers_from_an_array
      params = { id: '2',
        first_name: 'first_name2',
        last_name: 'last_name2',
        created_at: '2012-03-28 14:54:09 UTC',
        updated_at: '2012-03-29 14:54:09 UTC' }

      data = [Customer.new(params)]
      Customer.add data
      assert_equal 1, Customer.size
      assert_valid_customer params, Customer.find_by_id(2)
    end

    def test_it_returns_a_random_customer_when_random_is_called
      random_customer1 = Customer.random
      random_customer2 = Customer.random

      refute_equal random_customer1, random_customer2
    end

    def test_it_can_find_a_customer_by_first_name
      customer = Customer.find_by_first_name("Sylvester")
      assert_equal "Sylvester", customer.first_name
    end

    def test_it_can_find_all_customers_by_first_name
      all_mariahs = Customer.find_all_by_first_name("Mariah")
      assert_equal 2 , all_mariahs.length
    end

    def test_it_can_find_customer_by_id
      customer = Customer.find_by_id(10)
      assert_equal 10, customer.id
    end

    def test_it_can_find_customer_by_last_name
      customer = Customer.find_by_last_name("Upton")
      assert_equal "Upton", customer.last_name
    end

    def test_it_can_find_all_customers_by_last_name
      found_customers = Customer.find_all_by_last_name("Upton")
      assert_equal 2 , found_customers.length
    end

  end

end
