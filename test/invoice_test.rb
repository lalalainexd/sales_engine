
require 'minitest/autorun'
require 'minitest/pride'
require 'minitest/mock'


require './lib/invoice'

class InvoiceTest < MiniTest::Unit::TestCase

  def test_it_exists
    invoice = Invoice.new({})
    assert_kind_of Invoice, invoice
  end

  # def test_it_can_create_merchants
  #   data = [{id: 'id', name: 'name', created_at: 'date', updated_at: 'another_date'}]
  #   merchant = Merchant.populate data
  #   assert_equals 'id', merchant.id
  # end

  def test_it_is_initialized_from_a_hash_of_data
    invoice = Invoice.new(
                               id: 'id',
                               customer_id: 'customer_id',
                               merchant_id: 'merchant_id',
                               status: 'status',
                               created_at: 'date',
                               updated_at: 'another_date')

    assert_equal 'id', invoice.id
    assert_equal 'customer_id', invoice.customer_id
    assert_equal 'merchant_id', invoice.merchant_id
    assert_equal 'status', invoice.status
    assert_equal 'date', invoice.created_at
    assert_equal 'another_date', invoice.updated_at

    invoice = Invoice.new(
                               id: 'id2',
                               customer_id: 'customer_id2',
                               merchant_id: 'merchant_id2',
                               status: 'status2',
                               created_at: 'date2',
                               updated_at: 'another_date2')

    assert_equal 'id2', invoice.id
    assert_equal 'customer_id2', invoice.customer_id
    assert_equal 'merchant_id2', invoice.merchant_id
    assert_equal 'status2', invoice.status
    assert_equal 'date2', invoice.created_at
    assert_equal 'another_date2', invoice.updated_at
  end

  def test_it_stores_invoices_from_an_array
    invoice = Invoice.new({})
    data = [invoice]
    Invoice.add data
    assert_equal 1, Invoice.size

  end

  def test_it_returns_a_random_invoice
    CsvLoader.load_invoices

    result1 = Invoice.random
    result2 = Invoice.random

    refute_equal result1, result2
  end

  def test_it_finds_an_invoice_with_id
    CsvLoader.load_invoices
    invoice = Invoice.find_by_id("1")
    assert_equal "1", invoice.id

    invoice = Invoice.find_by_id("2")
    assert_equal "2", invoice.id
  end

  def test_it_finds_an_invoice_with_customer_id
    CsvLoader.load_invoices
    invoice = Invoice.find_by_customer_id("1")
    assert_equal "1", invoice.customer_id

    invoice = Invoice.find_by_customer_id("2")
    assert_equal "2", invoice.customer_id

  end

  def test_it_finds_an_invoice_with_merchant_id
    CsvLoader.load_invoices
    invoice = Invoice.find_by_merchant_id("26")
    assert_equal "26", invoice.merchant_id

    invoice = Invoice.find_by_merchant_id("75")
    assert_equal "75", invoice.merchant_id

  end

  def test_it_find_an_invoice_with_status
    CsvLoader.load_invoices
    invoice = Invoice.find_by_status("shipped")
    assert_equal "shipped", invoice.status
  end

  def test_it_find_an_invoice_with_created_at
    CsvLoader.load_invoices
    date = "2012-03-25 09:54:09 UTC"
    invoice = Invoice.find_by_created_at(date)
    assert_equal date, invoice.created_at

    date = "2012-03-13 16:54:10 UTC"
    invoice = Invoice.find_by_created_at(date)
    assert_equal date, invoice.created_at
  end

  def test_it_find_an_invoice_with_update_at
    CsvLoader.load_invoices
    date = "2012-03-13 16:54:10 UTC"
    invoice = Invoice.find_by_updated_at(date)
    assert_equal date, invoice.updated_at
  end
end
