require './test/test_helper'

class InvoiceItemTest < MiniTest::Unit::TestCase

  def setup

  end

  def test_it_exists
    invoice_item = InvoiceItem.new({})
    assert_kind_of = InvoiceItem, invoice_item
  end

  def test_it_is_initialized_from_a_hash_of_data
    invoice_item = InvoiceItem.new(
      id: 'id',
      item_id: 'item_id',
      invoice_id: 'invoice_id',
      quantity: 'quantity',
      unit_price: 'unit_price',
      created_at: '2012-03-27 14:54:09 UTC',
      updated_at: '2012-03-27 14:54:09 UTC'
    )

    date = DateTime.parse('2012-03-27 14:54:09 UTC')

    assert_equal 'id', invoice_item.id
    assert_equal 'item_id', invoice_item.item_id
    assert_equal 'invoice_id', invoice_item.invoice_id
    assert_equal 'quantity', invoice_item.quantity
    assert_equal 'unit_price', invoice_item.unit_price
    assert_equal date, invoice_item.created_at
    assert_equal date, invoice_item.updated_at

    invoice_item = InvoiceItem.new(
      id: 'id2',
      item_id: 'item_id2',
      invoice_id: 'invoice_id2',
      quantity: 'quantity2',
      unit_price: 'unit_price2',
      created_at: '2012-03-28 14:54:09 UTC',
      updated_at: '2012-03-28 14:54:09 UTC'
    )

    date = DateTime.parse('2012-03-28 14:54:09 UTC')

    assert_equal 'id2', invoice_item.id
    assert_equal 'item_id2', invoice_item.item_id
    assert_equal 'invoice_id2', invoice_item.invoice_id
    assert_equal 'quantity2', invoice_item.quantity
    assert_equal 'unit_price2', invoice_item.unit_price
    assert_equal date, invoice_item.created_at
    assert_equal date, invoice_item.updated_at
  end

  def test_it_stores_invoice_items_from_an_array
    data = [InvoiceItem.new( id: 'id2',
                            item_id: 'item_id2',
                            invoice_id: 'invoice_id2',
                            quantity: 'quantity2',
                            unit_price: 'unit_price2',
                            created_at: '2012-03-28 14:54:09 UTC',
                            updated_at: '2012-03-28 14:54:09 UTC')]
    InvoiceItem.add data
    assert_equal 1, InvoiceItem.size
  end

end