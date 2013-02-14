require './test/test_helper'

class CustomerTest < MiniTest::Unit::TestCase
  def setup
    @customers = CsvLoader.load_customers('./test/support/customers.csv')
  end

  def test_it_exists
    customer = Customer.new({})
    assert_kind_of Customer, customer
  end

 def test_it_is_initialized_from_a_hash_of_data
    customer = Customer.new(
                            id: 'id',
                            first_name: 'first_name',
                            last_name: 'last_name',
                            created_at: '2012-03-27 14:54:09 UTC',
                            updated_at: '2012-03-27 14:54:09 UTC' )

    created_date =  DateTime.parse("2012-03-27 14:54:09 UTC")
    updated_date = DateTime.parse("2012-03-27 14:54:09 UTC")

    assert_equal 'id', customer.id
    assert_equal 'first_name', customer.first_name
    assert_equal 'last_name', customer.last_name
    assert_equal created_date, customer.created_at
    assert_equal updated_date, customer.updated_at

    customer = Customer.new(
                          id: 'id2', first_name: 'first_name2',
                          last_name: 'last_name2',
                            created_at: '2012-03-28 14:54:09 UTC',
                            updated_at: '2012-03-29 14:54:09 UTC' )

    created_date =  DateTime.parse("2012-03-28 14:54:09 UTC")
    updated_date = DateTime.parse("2012-03-29 14:54:09 UTC")

    assert_equal 'id2', customer.id
    assert_equal 'first_name2', customer.first_name
    assert_equal 'last_name2', customer.last_name
    assert_equal created_date, customer.created_at
    assert_equal updated_date, customer.updated_at
    end

 def test_it_stores_customers_from_an_array
   data = [Customer.new( id: 'id2',
                        first_name: 'first_name2',
                        last_name: 'last_name2',
                        created_at: '2012-03-28 14:54:09 UTC',
                        updated_at: '2012-03-29 14:54:09 UTC' )]
   Customer.add data
     assert_equal 1, Customer.size
  end

  def test_it_returns_a_random_customer_when_random_is_called
    assert_equal 10, @customers.size

    random_customer1 = Customer.random
    assert_kind_of Customer, random_customer1
    #can i do a compare assert?
  end

  def test_it_can_find_a_customer_by_first_name
    customer = Customer.find_by_first_name("Sylvester")
    assert_equal "Sylvester", customer.first_name
  end

#### HOW DO I TEST FOR MULTIPLE RETURNS?
  def test_it_can_find_ALL_customers_by_first_name
    found_customers = Customer.find_all_by_first_name("Mariah")
    assert_equal 2 , found_customers.length
  end

  def test_it_can_find_customer_by_id
    customer = Customer.find_by_id("10")
    assert_equal "10", customer.id
  end

  def test_it_can_find_customer_by_last_name
    customer = Customer.find_by_last_name("Upton")
    assert_equal "Upton", customer.last_name
  end

#### HOW DO I TEST FOR MULTIPLE RETURNS?
  def test_it_can_find_ALL_customers_by_last_name
    found_customers = Customer.find_all_by_last_name("Upton")
    assert_equal 2 , found_customers.length
  end

  def test_it_returns_invoices_associated_with_a_customer
    customer = Customer.find_by_id("1")
    assert_equal 8 , customer.invoices.size
  end
end





