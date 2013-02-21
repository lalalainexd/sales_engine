require 'test_helper'

module SalesEngine
  class TransactionTest < MiniTest::Unit::TestCase
    include TestFileLoader

    def setup
      load_data_for(:transactions)
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
      assert_equal params[:credit_card_expiration_date], transaction.credit_card_expiration_date
      assert_equal params[:result], transaction.result
      assert_equal Date.parse(params[:created_at]), transaction.created_at
      assert_equal Date.parse(params[:updated_at]), transaction.updated_at
    end

    def test_it_is_initialized_from_a_hash_of_data
      transaction_params_1 = { id: '1',
        invoice_id: '1',
        credit_card_number: 'credit_card_number',
        credit_card_expiration_date: 'credit_card_expdate',
        result: 'result',
        created_at: '2012-03-27',
        updated_at: '2012-03-27'
      }
      transaction = Transaction.new(transaction_params_1)
      assert_transaction_is_correctly_defined(transaction,transaction_params_1)

      transaction_params_2 = {id: '2',
        invoice_id: '2',
        credit_card_number: 'credit_card_number2',
        credit_card_expiration_date: 'credit_card_expdate2',
        result: 'result2',
        created_at: '2012-03-29 14:53:59 UTC',
        updated_at: '2012-03-29 14:53:59 UTC'
      }
      transaction = Transaction.new(transaction_params_2)
      assert_transaction_is_correctly_defined(transaction,transaction_params_2)
    end

    def test_it_stores_transactions_from_an_array
      transaction = Transaction.new(id: '40',
                                    invoice_id: 'invoice_id',
                                    credit_card_number: 'credit_card_number',
                                    credit_card_expiration_date: 'credit_card_expiration_date',
                                    result: 'result',
                                    created_at: '2012-03-29 14:53:59 UTC',
                                    updated_at: '2012-03-29 14:53:59 UTC')

      Transaction.add [transaction]
      assert Transaction.find_by_id 40
    end

    def test_it_can_find_a_transaction_by_id
      transaction = Transaction.find_by_id 1
      assert_equal 1, transaction.id
    end

    def test_it_returns_an_assoiated_invoice
      load_data_for(:invoices)
      transaction = Transaction.find_by_id 1
      invoice = Invoice.find_by_id 1
      assert_equal invoice, transaction.invoice
    end

    def test_it_finds_all_transactions_by_invoice_id
      load_data_for(:transactions)
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

    def test_it_returns_a_random_transaction
        transaction1 = Transaction.random
        transaction2 = Transaction.random

        refute_equal transaction1, transaction2

    end

    def test_it_can_find_by_credit_card_number
        card_number = '4654405418249632'
        transaction = Transaction.find_by_credit_card_number card_number

        assert transaction
        assert_equal card_number, transaction.credit_card_number
    end

    def test_it_can_find_all_by_result
      transactions = Transaction.find_all_by_result "success"

      assert_equal 10, transactions.size
      assert_equal "success", transactions.sample.result
    end
  end
end
