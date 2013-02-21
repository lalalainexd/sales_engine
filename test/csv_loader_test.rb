require 'test_helper'
module SalesEngine
class CsvLoaderTest < MiniTest::Unit::TestCase


  # def teardown
  #   clear_all
  # end

  def test_it_loads_merchants
    merchants = CsvLoader.load_merchants('./test/support/merchants.csv')
    assert_equal 10, merchants.size

    assert_kind_of Merchant, merchants.first
  end

  def test_it_stores_merchants
    merchants = CsvLoader.load_merchants('./test/support/merchants.csv')
    assert_equal 10, Merchant.size
  end

  def test_it_loads_invoices
    invoices = CsvLoader.load_invoices('./test/support/invoices.csv')
    assert_equal 10, Invoice.size

    assert_kind_of Invoice, invoices.first
  end

  def test_it_stores_invoices
    invoices = CsvLoader.load_invoices('./test/support/invoices.csv')
    assert_equal 10, Invoice.size
  end

  def test_it_loads_invoice_items
    invoice_items = CsvLoader.load_invoice_items('./test/support/invoice_items.csv')
    assert_equal 10, invoice_items.size

    assert_kind_of InvoiceItem, invoice_items.first
  end

  def test_it_stores_invoice_items
    invoice_items = CsvLoader.load_invoice_items('./test/support/invoice_items.csv')
    assert_equal 10, InvoiceItem.size
  end

  def test_it_loads_items
    items = CsvLoader.load_items('./test/support/items.csv')
    assert_equal 9, items.size

    assert_kind_of Item, items.first
  end

  def test_it_stores_items
    items = CsvLoader.load_items('./test/support/items.csv')
    assert_equal 9, Item.size
  end

  def test_it_loads_transactions
    transactions = CsvLoader.load_transactions('./test/support/transactions.csv')
    assert_equal 12, transactions.size

    assert_kind_of Transaction, transactions.first
  end

  def test_it_stores_transactions
    transactions = CsvLoader.load_transactions('./test/support/transactions.csv')
    assert_equal 12, Transaction.size
  end

  def test_it_loads_customers
    customers = CsvLoader.load_customers('./test/support/customers.csv')
    assert_equal 10, customers.size

    assert_kind_of Customer, customers.first
  end

  def test_it_stores_customers
    customers = CsvLoader.load_customers('./test/support/customers.csv')
    assert_equal 10, Customer.size
  end
end
end
