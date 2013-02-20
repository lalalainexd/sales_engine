require './test/test_helper'

module SalesEngine
  class ItemTest < MiniTest::Unit::TestCase
    include TestFileLoader

    def setup
      load_data_for(:items)
    end

    def teardown
      clear_all
    end

    def test_it_exists
      item = Item.new({})
      assert_kind_of = Item, item
    end

    def assert_item_is_correctly_defined(item,params)
      assert_equal params[:id].to_i , item.id
      assert_equal params[:name], item.name
      assert_equal params[:description], item.description
      assert_equal BigDecimal.new(params[:unit_price])/100, item.unit_price
      assert_equal params[:merchant_id].to_i, item.merchant_id
      assert_equal Date.parse(params[:created_at]), item.created_at
      assert_equal Date.parse(params[:updated_at]), item.updated_at
    end

    def test_it_is_initialized_from_a_hash_of_data
      params_1 = { id: '1', name: 'name', description: 'description',
        unit_price: 'unit_price', merchant_id: '1',
        created_at: '2012-03-27 14:53:59 UTC',
        updated_at: '2012-03-27 14:53:59 UTC'
      }
      item = Item.new(params_1)
      assert_item_is_correctly_defined(item, params_1)

      params_2 = {id: '2', name: 'name2', description: 'description2',
        unit_price: 'unit_price2', merchant_id: '2',
        created_at: '2012-03-28 14:53:59 UTC',
        updated_at: '2012-03-28 14:53:59 UTC'
      }
      item = Item.new(params_2)
      assert_item_is_correctly_defined(item, params_2)
    end

    def test_it_stores_items_from_an_array
      data = [Item.new( id: '1', name: 'name', description: 'description',
                       unit_price: 'unit_price', merchant_id: 'merchant_id',
                       created_at: '2012-03-28 14:53:59 UTC', updated_at: '2012-03-28 14:53:59 UTC'
                      )]

                      Item.add(data)
                      assert_equal 1, Item.size
                      assert Item.find_by_id 1
    end

    def test_it_returns_a_random_item
      item1 = Item.random
      item2 = Item.random
      refute_equal item1, item2
    end

    def test_it_finds_an_item_by_id
      id = 1
      item = Item.find_by_id id
      assert_equal id, item.id
    end

    def test_it_finds_an_item_by_name
      name = "Item Qui Esse"
      item = Item.find_by_name name
      assert_equal name, item.name

      name = "Item Autem Minima"
      item = Item.find_by_name name
      assert_equal name, item.name
    end

    def test_it_finds_an_item_by_description
      description = "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro."
      item = Item.find_by_description description
      assert_equal description, item.description

      description = "Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora."
      item = Item.find_by_description description
      assert_equal description, item.description
    end

    def test_it_finds_an_item_by_unit_price
      unit_price = BigDecimal.new("751.07")
      item = Item.find_by_unit_price unit_price
      assert_equal 1, item.id

      unit_price = BigDecimal.new("687.23")
      item = Item.find_by_unit_price unit_price
      assert_equal 5, item.id
    end

    def test_it_finds_an_item_by_merchant_id
      merchant_id = 1
      item = Item.find_by_merchant_id merchant_id
      assert_equal merchant_id, item.merchant_id

      merchant_id = 2
      item = Item.find_by_merchant_id merchant_id
      assert_equal merchant_id, item.merchant_id
    end

    def test_it_find_all_items_by_name
      name = "Item Qui Esse"
      items = Item.find_all_by_name name
      assert_equal 1, items.size

      name = "Item Autem Minima"
      items = Item.find_all_by_name name
      assert_equal 1, items.size
    end

    def test_it_returns_empty_for_nonexistant_name
      name = "blah"
      items = Item.find_all_by_name name
      assert items.empty?
    end

    def test_it_find_all_items_by_merchant_id
      merchant_id = 1
      items = Item.find_all_by_merchant_id merchant_id
      assert_equal 8, items.size

      merchant_id = 2
      items = Item.find_all_by_merchant_id merchant_id
      assert_equal 1, items.size
    end

    def test_it_returns_empty_for_nonexistant_merchant_id
      merchant_id = "blah"
      items = Item.find_all_by_merchant_id merchant_id
      assert items.empty?
    end

    def test_it_find_all_items_by_unit_price
      unit_price = BigDecimal.new("751.07")
      items = Item.find_all_by_unit_price unit_price
      assert_equal 2, items.size

      unit_price = BigDecimal.new("687.23")
      items = Item.find_all_by_unit_price unit_price
      assert_equal 2, items.size
    end

    def test_it_returns_empty_for_nonexistant_unit_price
      unit_price = "23589012301"
      items = Item.find_all_by_unit_price unit_price
      assert items.empty?
    end

    def test_it_find_all_items_by_description
      description = "Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non. Atque eveniet sed. Illum excepturi praesentium reiciendis voluptatibus eveniet odit perspiciatis. Odio optio nisi rerum nihil ut."
      items = Item.find_all_by_description description
      assert_equal 1, items.size
    end

    def test_it_returns_empty_for_nonexistant_description
      description = "dadadad dadadad"
      items = Item.find_all_by_description description
      assert items.empty?
    end

    def test_it_finds_all_by_created_at
      date = Date.parse("2012-03-27 14:53:59 UTC")
      items = Item.find_all_by_created_at date
      assert_equal 9, items.size
      assert_equal date, items.sample.created_at

      date = Date.parse("2012-03-27 14:54:08 UTC")
      items = Item.find_all_by_created_at date
      assert_equal 9, items.size
      assert_equal date, items.sample.created_at
    end

    def test_returns_empty_array_with_non_existing_created_date
      date = Date.parse "1999-03-06 15:55:33 UTC"
      items = Item.find_all_by_created_at date
      assert_equal 0, items.size
    end

    def test_it_finds_all_by_updated_at
      date = Date.parse "2012-03-27 14:53:59 UTC"
      items = Item.find_all_by_updated_at date
      assert_equal 9, items.size
      assert_equal date, items.sample.updated_at

      date = Date.parse "2012-03-27 14:54:00 UTC"
      items = Item.find_all_by_updated_at date
      assert_equal 9, items.size
      assert_equal date, items.sample.updated_at
    end

    def test_returns_empty_array_with_non_existing_updated_date
      date = Date.parse "1999-03-06 15:55:33 UTC"
      items = Item.find_all_by_updated_at date
      assert_equal 0, items.size
    end

    def test_it_returns_a_collection_of_associated_invoice_items
      load_data_for(:invoice_items)
      item = Item.find_by_id 1
      assert_equal 3, item.invoice_items.size
    end

    def test_it_returns_the_associated_merchant
      load_data_for(:merchants)
      item = Item.find_by_id 1
      merchant = Merchant.find_by_id 1
      assert_equal merchant, item.merchant
    end
  end
end
