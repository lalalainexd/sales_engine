require './test/test_helper'

class MerchantBusinessIntTest < MiniTest::Unit::TestCase
  include TestFileLoader

  def setup
    CsvLoader.load_invoices
    CsvLoader.load_invoice_items
    CsvLoader.load_transactions
    CsvLoader.load_merchants
  end

  def teardown
    clear_all
  end

def test_it_returns_a_merchants_total_revenue
    merchant = Merchant.find_by_name("Dicki-Bednar")
    assert_equal 1148393.74 , merchant.revenue 
  end

  def test_it_returns_a_merchants_total_revenue_for_a_specific_date
    merchant = Merchant.find_by_name("Willms and Sons")
    date = Date.parse("Fri, 09 Mar 2012")
    assert_equal 8373.29, merchant.revenue(date)
  end

   def test_it_returns_customers_with_pending_transactions_for_a_merchant
    merchant = Merchant.find_by_name("Parisian Group")
    assert_equal 4, merchant.customers_with_pending_invoices.size
  end

  def test_it_returns_a_merchants_most_loyal_customer
    CsvLoader.load_customers
    merchant = Merchant.find_by_name("Terry-Moore")
    assert_equal "Jayme" , merchant.favorite_customer.first_name
  end

   def test_it_returns_total_revenue_for_a_specific_date_for_all_merchants
    date =Date.parse("Tue, 20 Mar 2012")
    assert_equal 2549722.91, Merchant.revenue(date)
  end

  # def test_it_returns_top_X_merchants_by_revenue
  #   top3 = Merchant.most_revenue(3)
  #   assert_equal 3, top3.size
  #   assert_equal "Dicki-Bednar" , top3[0].name
  # end

  def test_it_returns_the_top_X_merchants_based_on_number_of_items_sold
    top5 = Merchant.most_items(5)
    assert_equal 5, top5.size
    assert_equal "Kassulke, O'Hara and Quitzon" , top5[0].name
    assert_equal "Daugherty Group", top5[4].name
  end

end
