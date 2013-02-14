require './test/test_helper'

class TransactionTest < MiniTest::Unit::TestCase

  def test_it_exists
    transaction = Transaction.new({})
    assert_kind_of Transaction, transaction
  end

  def test_it_is_initialized_from_a_hash_of_data
    transaction = Transaction.new(
      id: 'id',
      invoice_id: 'invoice_id',
      credit_card_number: 'credit_card_number',
      credit_card_expiration_date: 'credit_card_expdate',
      result: 'result',
      created_at: '2012-03-27 14:53:59 UTC',
      updated_at: '2012-03-27 14:53:59 UTC'
    )

    date = DateTime.parse('2012-03-27 14:53:59 UTC')

    assert_equal 'id', transaction.id
    assert_equal 'invoice_id', transaction.invoice_id
    assert_equal 'credit_card_number', transaction.credit_card_number
    assert_equal 'credit_card_expdate', transaction.credit_card_expiration_date
    assert_equal 'result', transaction.result
    assert_equal date, transaction.created_at
    assert_equal date, transaction.updated_at

    transaction = Transaction.new(
      id: 'id2',
      invoice_id: 'invoice_id2',
      credit_card_number: 'credit_card_number2',
      credit_card_expiration_date: 'credit_card_expiration_date2',
      result: 'result2',
      created_at: '2012-03-29 14:53:59 UTC',
      updated_at: '2012-03-29 14:53:59 UTC'
    )

    date = DateTime.parse('2012-03-29 14:53:59 UTC')

      assert_equal 'id2', transaction.id
      assert_equal 'invoice_id2', transaction.invoice_id
      assert_equal 'credit_card_number2', transaction.credit_card_number
      assert_equal 'credit_card_expiration_date2', transaction.credit_card_expiration_date
      assert_equal 'result2', transaction.result
      assert_equal date, transaction.created_at
      assert_equal date, transaction.updated_at
  end

  def test_it_stores_transactions_from_an_array
    transaction = Transaction.new(
      id: 'id',
      invoice_id: 'invoice_id',
      credit_card_number: 'credit_card_number',
      credit_card_expiration_date: 'credit_card_expiration_date',
      result: 'result',
      created_at: '2012-03-29 14:53:59 UTC',
      updated_at: '2012-03-29 14:53:59 UTC'
    )
      data = [transaction]
      Transaction.add data
      assert_equal 1, Transaction.size
  end

  def test_it_finds_all_transactions_by_invoice_id
    transactions = Transaction.find_all_by_invoice_id("12")
    assert_equal 3 , transactions.size
  end
end
