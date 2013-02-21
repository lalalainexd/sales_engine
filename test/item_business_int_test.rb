require 'test_helper'

module SalesEngine
  class ItemBusinessIntTest < MiniTest::Unit::TestCase
    include TestFileLoader

    def setup
      load_data_for(:items, :invoice_items, :transactions, :invoices)
    end

    def teardown
      clear_all
    end

    def test_it_returns_the_three_highest_revenue_item
      CsvLoader.load_items
      CsvLoader.load_invoice_items
      CsvLoader.load_transactions
      CsvLoader.load_invoices

      items = Item.most_revenue(5)

      assert_equal 5, items.size
      assert_equal 'Item Dicta Autem', items.first.name
      assert_equal 'Item Amet Accusamus', items.last.name
    end

    def test_it_returns_the_three_most_sold_items
      CsvLoader.load_items
      CsvLoader.load_invoice_items
      CsvLoader.load_transactions
      CsvLoader.load_invoices

      items = Item.most_items(37)

      assert_equal 'Item Nam Magnam', items[1].name
      assert_equal 'Item Ut Quaerat', items.last.name
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
end
