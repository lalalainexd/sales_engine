require './test/test_helper'

module SalesEngine
  class InvoiceTest < MiniTest::Unit::TestCase
    include TestFileLoader

    def setup
      load_data_for :invoices
    end

    def teardown
      clear_all
    end


    def test_it_returns_the_customer_associated_with_the_invoice
      load_data_for :customers
      invoice = Invoice.find_by_id(1)
      assert_equal "Joey" , invoice.customer.first_name
    end

    def test_it_returns_transactions_associated_with_an_invoice
      load_data_for :transactions
      invoice = Invoice.find_by_id(1)
      assert_equal 1 , invoice.transactions.size
    end

    def test_it_returns_a_collection_of_invoice_item_instances
      load_data_for :items, :invoice_items
      invoice = Invoice.find_by_id(2)
      assert_equal 2 , invoice.invoice_items.size
    end

    def test_it_returns_a_collection_of_items_by_way_of_invoiceitem_objects
      load_data_for :items, :invoice_items
      invoice = Invoice.find_by_id(2)
      assert_equal 2 , invoice.items.size
    end

    def test_it_knows_if_its_successful
      load_data_for :transactions
      invoice = Invoice.find_by_id 1
      assert invoice.success?

    end

    def test_it_charges_the_invoice
      load_data_for :customers, :merchants, :items

      customer = Customer.find_by_id 2
      merchant = Merchant.find_by_id 1

      invoice = Invoice.create(customer: customer, merchant: merchant, items: [])

      invoice.charge(credit_card_number: "4444333322221111",
                     credit_card_expiration: "10/13", result: "success")

      assert_equal 1, Transaction.size

    end

  end

  #Tests class methods
  class InvoiceClassTest < MiniTest::Unit::TestCase
    include TestFileLoader

    def setup
      load_data_for :invoices
    end

    def teardown
      clear_all
    end

    def test_it_exists
      invoice = Invoice.new({})
      assert_kind_of Invoice, invoice
    end

    def assert_valid_invoice params, invoice
      assert_equal params[:id].to_i, invoice.id
      assert_equal params[:customer_id].to_i, invoice.customer_id
      assert_equal params[:merchant_id].to_i, invoice.merchant_id
      assert_equal params[:status], invoice.status
      assert_equal Date.parse(params[:created_at]), invoice.created_at
      assert_equal Date.parse(params[:updated_at]), invoice.updated_at
    end

    def test_it_is_initialized_from_a_hash_of_data
      params = {id: '1',
        customer_id: '1',
        merchant_id: '1',
        status: 'status',
        created_at: '2012-03-28 14:54:09 UTC',
        updated_at: '2012-03-28 14:54:09 UTC'
      }

      params2 = {id: '2',
        customer_id: '2',
        merchant_id: '2',
        status: 'status2',
        created_at: '2012-03-29 14:54:09 UTC',
        updated_at: '2012-03-29 14:54:09 UTC'}

      assert_valid_invoice params, Invoice.new(params)
      assert_valid_invoice params2, Invoice.new(params2)

    end

    def test_it_stores_invoices_from_an_array
      invoice = Invoice.new({})
      data = [invoice]
      Invoice.add data
      assert_equal 1, Invoice.size

    end

    def test_it_returns_a_random_invoice
      result1 = Invoice.random
      result2 = Invoice.random

      refute_equal result1, result2
    end

    def test_it_finds_an_invoice_by_id
      invoice = Invoice.find_by_id(1)
      assert_equal 1, invoice.id

      invoice = Invoice.find_by_id(2)
      assert_equal 2, invoice.id
    end

    def test_it_finds_an_invoice_by_customer_id
      invoice = Invoice.find_by_customer_id(1)
      assert_equal 1, invoice.customer_id

      invoice = Invoice.find_by_customer_id(2)
      assert_equal 2, invoice.customer_id

    end

    def test_it_finds_an_invoice_by_merchant_id
      invoice = Invoice.find_by_merchant_id(26)
      assert_equal 26, invoice.merchant_id

      invoice = Invoice.find_by_merchant_id(75)
      assert_equal 75, invoice.merchant_id

    end

    def test_it_finds_an_invoice_by_status
      invoice = Invoice.find_by_status("shipped")
      assert_equal "shipped", invoice.status
    end

    def test_it_finds_an_invoice_by_created_at
      date = Date.parse("2012-03-25 09:54:09 UTC")
      invoice = Invoice.find_by_created_at(date)
      assert_equal date, invoice.created_at

      date = Date.parse("2012-03-13 16:54:10 UTC")
      invoice = Invoice.find_by_created_at(date)
      assert_equal date, invoice.created_at
    end

    def test_it_finds_an_invoice_by_update_at
      date = Date.parse("2012-03-13 16:54:10 UTC")
      invoice = Invoice.find_by_updated_at(date)
      assert_equal date, invoice.updated_at
    end

    def test_it_finds_all_by_customer_id
      customer_id = 1
      invoices = Invoice.find_all_by_customer_id customer_id
      assert_equal 8, invoices.size
      assert_equal 1, invoices.sample.customer_id

      customer_id = 2
      invoices = Invoice.find_all_by_customer_id customer_id
      assert_equal 1, invoices.size
      assert_equal 2, invoices.sample.customer_id

    end

    def test_returns_empty_array_with_non_existing_customer_id
      customer_id = 0
      invoices = Invoice.find_all_by_customer_id customer_id
      assert_equal 0, invoices.size

    end

    def test_it_finds_all_by_merchant_id
      merchant_id = 76
      invoices = Invoice.find_all_by_merchant_id merchant_id
      assert_equal 1, invoices.size
      assert_equal merchant_id, invoices.sample.merchant_id

      merchant_id = 26
      invoices = Invoice.find_all_by_merchant_id merchant_id
      assert_equal 1, invoices.size
      assert_equal merchant_id, invoices.sample.merchant_id
    end

    def test_returns_empty_array_with_non_existing_merchant_id
      merchant = 0
      invoices = Invoice.find_all_by_merchant_id merchant
      assert_equal 0, invoices.size
    end

    def test_it_finds_all_invoices_by_status
      invoices =Invoice.find_all_by_status("shipped")
      assert_equal 10 , invoices.size

      invoices2 =Invoice.find_all_by_status("failed")
      assert_equal 0 , invoices2.size
    end

    def test_it_finds_all_by_created_at
      date = Date.parse("2012-03-25 09:54:09 UTC")
      invoices = Invoice.find_all_by_created_at date
      assert_equal 1, invoices.size
      assert_equal date, invoices.sample.created_at

      date = Date.parse("2012-03-09 01:54:10 UTC")
      invoices = Invoice.find_all_by_created_at date
      assert_equal 1, invoices.size
      assert_equal date, invoices.sample.created_at
    end

    def test_returns_empty_array_with_non_existing_created_date
      date = "1999-03-06 15:55:33 UTC"
      invoices = Invoice.find_all_by_created_at date
      assert_equal 0, invoices.size
    end

    def test_it_finds_all_by_updated_at
      date = Date.parse("2012-03-12 05:54:09 UTC")
      invoices = Invoice.find_all_by_updated_at date
      assert_equal 1, invoices.size
      assert_equal date, invoices.sample.updated_at

      date = Date.parse("2012-03-07 12:54:10 UTC")
      invoices = Invoice.find_all_by_updated_at date
      assert_equal 3, invoices.size
      assert_equal date, invoices.sample.updated_at
    end

    def test_returns_empty_array_with_non_existing_updated_date
      date = Date.parse("1999-03-06 15:55:33 UTC")
      invoices = Invoice.find_all_by_updated_at date
      assert_equal 0, invoices.size
    end

    def test_it_creates_an_invoice
      load_data_for :customers, :merchants
      customer = Customer.find_by_id 2
      merchant = Merchant.find_by_id 1

      params = {
        customer: customer,
        merchant: merchant,
        items: [],
        status: "shipped"
      }

      invoice = Invoice.create(params)

      params[:customer_id] = customer.id
      params[:merchant_id] = merchant.id
      params[:created_at] = Date.today.to_s
      params[:updated_at] = Date.today.to_s
      params[:id] = '11'

      assert_valid_invoice params, invoice
    end

    def test_it_creates_invoice_items
      load_data_for :customers, :merchants, :items

      customer = Customer.find_by_id 2
      merchant = Merchant.find_by_id 1

      item1 = Item.find_by_id(1)
      item2 = Item.find_by_id(2)

      items = [item1, item2, item2]


      invoice = Invoice.create(
        customer: customer,
        merchant: merchant,
        items: items
      )

      assert_equal 2, InvoiceItem.size

    end
  end
end
