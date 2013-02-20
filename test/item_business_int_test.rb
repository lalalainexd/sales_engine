require './test/test_helper'

class ItemBusinessIntTest < MiniTest::Unit::TestCase
  include TestFileLoader

  def setup
    load_data_for(:items, :invoice_items, :transactions, :invoices)
  end

  def teardown
    clear_all
  end
 
  def test_it_returns_the_highest_revenue_item
    items = Item.most_revenue(1)
    
    assert_equal 1, items.size
    assert_equal 2, items.first.id
  end

  def test_it_returns_the_three_highest_revenue_item
    items = Item.most_revenue(3)

    assert_equal 3, items.size
    assert_equal 2, items.first.id
    assert_equal 1, items[1].id
  end

  def test_it_returns_the_most_sold_item
    items = Item.most_items(1)

    assert_equal 1, items.size
    assert_equal 1, items.first.id
  end

  def test_it_returns_the_three_most_sold_items
    items = Item.most_items(3)

    assert_equal 3, items.size
    assert_equal 1, items.first.id
    assert_equal 2, items[1].id
  end

  def test_it_returns_the_date_with_most_sales
    CsvLoader.load_items
    CsvLoader.load_invoice_items
    CsvLoader.load_invoices
    CsvLoader.load_transactions

    item = Item.find_by_name "Item Accusamus Ut"
    date = Date.parse "Sat, 24 Mar 2012"

    assert_equal date, item.best_day
  end
end
