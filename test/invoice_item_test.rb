require './test/test_helper'

class InvoiceItemTest < MiniTest::Unit::TestCase

  def setup
    CsvLoader.load_invoice_items('./test/support/invoice_items.csv')
  end

  def teardown
    clear_all
  end

  def test_it_exists
    invoice_item = InvoiceItem.new({})
    assert_kind_of = InvoiceItem, invoice_item
  end

  def test_it_is_initialized_from_a_hash_of_data
    invoice_item = InvoiceItem.new(
      id: '1',
      item_id: '1',
      invoice_id: '1',
      quantity: '2',
      unit_price: '1',
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
    )

    date = Date.parse('2012-03-27 14:54:09 UTC')

    assert_equal 1, invoice_item.id
    assert_equal 1, invoice_item.item_id
    assert_equal 1, invoice_item.invoice_id
    assert_equal 2, invoice_item.quantity
    assert_equal 1, invoice_item.unit_price
    assert_equal date, invoice_item.created_at
    assert_equal date, invoice_item.updated_at

    invoice_item = InvoiceItem.new(
      id: '2',
      item_id: '2',
      invoice_id: '2',
      quantity: '1',
      unit_price: '2',
      created_at: '2012-03-28 14:54:09 UTC',
      updated_at: '2012-03-28 14:54:09 UTC'
    )

    date = Date.parse('2012-03-28 14:54:09 UTC')

    assert_equal 2, invoice_item.id
    assert_equal 2, invoice_item.item_id
    assert_equal 2, invoice_item.invoice_id
    assert_equal 1, invoice_item.quantity
    assert_equal 2, invoice_item.unit_price
    assert_equal date, invoice_item.created_at
    assert_equal date, invoice_item.updated_at
  end

  def test_it_stores_invoice_items_from_an_array
    data = [InvoiceItem.new( id: 2,
                            item_id: '4',
                            invoice_id: '4',
                            quantity: '4',
                            unit_price: '4',
                            created_at: '2012-03-28 14:54:09 UTC',
                            updated_at: '2012-03-28 14:54:09 UTC')]
    InvoiceItem.add data
    assert_equal 1, InvoiceItem.size
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

  def test_it_returns_the_invoice_associated_with_the_invoice_item
    CsvLoader.load_invoices './test/support/invoices.csv'

    invoice_item = InvoiceItem.find_by_id 1
    invoice = Invoice.find_by_id 1
    assert_equal  invoice, invoice_item.invoice
  end

  def test_it_returns_an_item_associated_with_the_invoice_item
    CsvLoader.load_items './test/support/items.csv'
    invoice_item = InvoiceItem.find_by_id 1
    item = Item.find_by_id 1
    assert_equal  item, invoice_item.item
  end

  def test_it_creates_an_invoice_item
    CsvLoader.load_items './test/support/items.csv'

    invoice = Invoice.new id: '1'

    item = Item.random

    invoice_item = InvoiceItem.create item: item, quantity: '1', unit_price: '123', invoice: invoice
    assert_equal 11, InvoiceItem.size
  end
end
