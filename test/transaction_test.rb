require './test/test_helper'

class TransactionTest < MiniTest::Unit::TestCase

  def setup
    CsvLoader.load_transactions('./test/support/transactions.csv')
  end

  def test_it_exists
    transaction = Transaction.new({})
    assert_kind_of Transaction, transaction
  end

  def teardown
    clear_all
  end

  def assert_transaction_is_correctly_defined(transaction,params)
    assert_equal params[:id].to_i , transaction.id
    assert_equal params[:invoice_id].to_i, transaction.invoice_id
    assert_equal params[:credit_card_number], transaction.credit_card_number
    assert_equal 'credit_card_expdate', transaction.credit_card_expiration_date
    assert_equal 'result', transaction.result
    assert_equal Date.parse(params[:created_at]), transaction.created_at
    assert_equal Date.parse(params[:updated_at]), transaction.updated_at
  end

  def test_it_is_initialized_from_a_hash_of_data
    transaction_params = { id: '1',
      invoice_id: '1',
      credit_card_number: 'credit_card_number',
      credit_card_expiration_date: 'credit_card_expdate',
      result: 'result',
      created_at: '2012-03-27',
      updated_at: '2012-03-27'
    }

    transaction = Transaction.new(transaction_params)

    date = Date.parse('2012-03-27 14:53:59 UTC')

    assert_transaction_is_correctly_defined(transaction,transaction_params)

    assert_equal 1 , transaction.id
    assert_equal 1, transaction.invoice_id
    assert_equal 'credit_card_number', transaction.credit_card_number
    assert_equal 'credit_card_expdate', transaction.credit_card_expiration_date
    assert_equal 'result', transaction.result
    assert_equal date, transaction.created_at
    assert_equal date, transaction.updated_at

    transaction = Transaction.new(
      id: '2',
      invoice_id: '2',
      credit_card_number: 'credit_card_number2',
      credit_card_expiration_date: 'credit_card_expiration_date2',
      result: 'result2',
      created_at: '2012-03-29 14:53:59 UTC',
      updated_at: '2012-03-29 14:53:59 UTC'
    )

    date = Date.parse('2012-03-29 14:53:59 UTC')

      assert_equal 2, transaction.id
      assert_equal 2, transaction.invoice_id
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

  def test_it_can_find_a_transaction_by_id
    transaction = Transaction.find_by_id 1
    assert_equal 1, transaction.id
  end

  def test_it_returns_an_assoiated_invoice
    CsvLoader.load_invoices('./test/support/invoices.csv')
    transaction = Transaction.find_by_id 1
    invoice = Invoice.find_by_id 1
    assert_equal invoice, transaction.invoice
  end

  def test_it_finds_all_transactions_by_invoice_id
    CsvLoader.load_invoices('./test/support/invoices.csv')
    transactions = Transaction.find_all_by_invoice_id(12)
    assert_equal 3 , transactions.size
  end

  def test_it_creates_and_adds_a_transaction
    credit_card_number = '1111222233334444'
    expiration_date = '10/13'
    result = 'success'
    invoice_id = 1

    transaction = Transaction.create invoice_id: invoice_id,
      credit_card_number: credit_card_number,
      credit_card_expiration_date: expiration_date,
      result: result

    assert_equal 13, Transaction.size
    assert_equal credit_card_number, transaction.credit_card_number
    assert_equal expiration_date, transaction.credit_card_expiration_date
    assert_equal result, transaction.result
    assert_equal 14, transaction.id
  end
end
