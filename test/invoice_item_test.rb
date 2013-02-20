require './test/test_helper'

module SalesEngine

  class InvoiceItemTest < MiniTest::Unit::TestCase
    include TestFileLoader

    def setup
      load_data_for :invoice_items
    end

    def teardown
      clear_all
    end

    def test_it_returns_the_invoice_associated_with_the_invoice_item
      load_data_for :invoices

      invoice_item = InvoiceItem.find_by_id 1
      invoice = Invoice.find_by_id 1
      assert_equal  invoice, invoice_item.invoice
    end

    def test_it_returns_an_item_associated_with_the_invoice_item
      load_data_for :items

      invoice_item = InvoiceItem.find_by_id 1
      item = Item.find_by_id 1
      assert_equal  item, invoice_item.item
    end

    def test_it_creates_an_invoice_item
      load_data_for :items

      invoice = Invoice.new(id: '1')
      item = Item.random

      invoice_item = InvoiceItem.create(item: item,
                                        quantity: '1', unit_price: '123', invoice: invoice)

      assert_equal 11, InvoiceItem.size

    end
  end

  #Test class methods
  class InvoiceItemClassTest < MiniTest::Unit::TestCase
    include TestFileLoader

    def setup
      load_data_for :invoice_items
    end

    def teardown
      clear_all
    end

    def test_it_exists
      invoice_item = InvoiceItem.new({})
      assert_kind_of = InvoiceItem, invoice_item
    end

    def assert_valid_invoice_item params, invoice_item
      assert_equal params[:id].to_i, invoice_item.id
      assert_equal params[:item_id].to_i, invoice_item.item_id
      assert_equal params[:invoice_id].to_i, invoice_item.invoice_id
      assert_equal params[:quantity].to_i, invoice_item.quantity
      assert_equal params[:unit_price].to_i, invoice_item.unit_price
      assert_equal Date.parse(params[:created_at]), invoice_item.created_at
      assert_equal Date.parse(params[:updated_at]), invoice_item.updated_at
    end

    def test_it_is_initialized_from_a_hash_of_data
      params = { id: '1',
        item_id: '1',
        invoice_id: '1',
        quantity: '2',
        unit_price: '1',
        created_at: '2012-03-27 14:54:09 UTC',
        updated_at: '2012-03-27 14:54:09 UTC'
      }

      params2 = { id: '2',
        item_id: '2',
        invoice_id: '2',
        quantity: '1',
        unit_price: '2',
        created_at: '2012-03-28 14:54:09 UTC',
        updated_at: '2012-03-28 14:54:09 UTC'
      }

      assert_valid_invoice_item params, InvoiceItem.new(params)
      assert_valid_invoice_item params2, InvoiceItem.new(params2)

    end

    def test_it_stores_invoice_items_from_an_array
      params = { id: '2',
        item_id: '2',
        invoice_id: '2',
        quantity: '1',
        unit_price: '2',
        created_at: '2012-03-28 14:54:09 UTC',
        updated_at: '2012-03-28 14:54:09 UTC'
      }

      InvoiceItem.add [InvoiceItem.new(params)]
      assert_valid_invoice_item params, InvoiceItem.find_by_id(2)

    end

    def test_it_returns_all_invoice_items_by_a_created_at_date
      date = Date.parse("2012-03-27 14:54:09 UTC")
      found_invoice_items = InvoiceItem.find_all_by_created_at(date)
      assert_equal 10, found_invoice_items.size
    end

    def test_it_returns_all_invoice_items_by_invoice_id
      found_invoice_items = InvoiceItem.find_all_by_invoice_id(1)
      assert_equal 8, found_invoice_items.size
    end

    def test_it_returns_all_invoice_items_by_item_id
      #CsvLoader.load_items './test/support/items.csv'
      found_invoice_items = InvoiceItem.find_all_by_item_id(534)
      assert_equal 1, found_invoice_items.size
    end
  end
end
