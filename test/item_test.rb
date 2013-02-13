require './lib/csv_loader'
require './lib/item'

class ItemTest < MiniTest::Unit::TestCase

  def test_it_exists
    item = Item.new({})
     assert_kind_of = Item, item
  end

  def test_it_is_initialized_from_a_hash_of_data
    item = Item.new(
                    id: 'id', name: 'name', description: 'description',
                    unit_price: 'unit_price', merchant_id: 'merchant_id',
                    created_at: 'created_at', updated_at: 'updated_at' )
    assert_equal 'id', item.id
    assert_equal 'name', item.name
    assert_equal 'description', item.description
    assert_equal 'unit_price', item.unit_price
    assert_equal 'merchant_id', item.merchant_id
    assert_equal 'created_at', item.created_at
    assert_equal 'updated_at', item.updated_at

    item = Item.new(
                    id: 'id2', name: 'name2', description: 'description2',
                    unit_price: 'unit_price2', merchant_id: 'merchant_id2',
                    created_at: 'created_at2', updated_at: 'updated_at2' )
    assert_equal 'id2', item.id
    assert_equal 'name2', item.name
    assert_equal 'description2', item.description
    assert_equal 'unit_price2', item.unit_price
    assert_equal 'merchant_id2', item.merchant_id
    assert_equal 'created_at2', item.created_at
    assert_equal 'updated_at2', item.updated_at
  end

  def test_it_stores_items_from_an_array
   data = [Item.new(
                    id: 'id', name: 'name', description: 'description',
                    unit_price: 'unit_price', merchant_id: 'merchant_id',
                    created_at: 'created_at', updated_at: 'updated_at' )]
    Item.add(data)
    assert_equal 1, Item.size
   end

  def test_it_returns_a_random_item
		CsvLoader.load_items

    item1 = Item.random
    item2 = Item.random
		refute_equal item1, item2

  end

	def test_it_finds_an_item_by_id
		CsvLoader.load_items

		id = "1"
		item = Item.find_by_id id
		assert_equal id, item.id

		id = "2"
		item = Item.find_by_id id
		assert_equal id, item.id
	end

	def test_it_finds_an_item_by_name
		CsvLoader.load_items

		name = "Item Qui Esse"
		item = Item.find_by_name name
		assert_equal name, item.name

		name = "Item Autem Minima"
		item = Item.find_by_name name
		assert_equal name, item.name
	end

	def test_it_finds_an_item_by_description
		CsvLoader.load_items

		description = "Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro."
		item = Item.find_by_description description
		assert_equal description, item.description

		description = "Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora."
		item = Item.find_by_description description
		assert_equal description, item.description
	end


	def test_it_finds_an_item_by_unit_price
		CsvLoader.load_items

		unit_price = "75107"
		item = Item.find_by_unit_price unit_price
		assert_equal unit_price, item.unit_price

		unit_price = "67076"
		item = Item.find_by_unit_price unit_price
		assert_equal unit_price, item.unit_price
	end

	def test_it_finds_an_item_by_merchant_id
		CsvLoader.load_items

		merchant_id = "1"
		item = Item.find_by_merchant_id merchant_id
		assert_equal merchant_id, item.merchant_id

		merchant_id = "2"
		item = Item.find_by_merchant_id merchant_id
		assert_equal merchant_id, item.merchant_id
	end

end