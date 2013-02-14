require './lib/csv_loader'
require './lib/item'

class ItemTest < MiniTest::Unit::TestCase

  def setup
    CsvLoader.load_items
  end

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

    item1 = Item.random
    item2 = Item.random
    refute_equal item1, item2

  end

  def test_it_finds_an_item_by_id

    id = "1"
    item = Item.find_by_id id
    assert_equal id, item.id

    id = "2"
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

    unit_price = "75107"
    item = Item.find_by_unit_price unit_price
    assert_equal unit_price, item.unit_price

    unit_price = "67076"
    item = Item.find_by_unit_price unit_price
    assert_equal unit_price, item.unit_price
  end

  def test_it_finds_an_item_by_merchant_id

    merchant_id = "1"
    item = Item.find_by_merchant_id merchant_id
    assert_equal merchant_id, item.merchant_id

    merchant_id = "2"
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

    merchant_id = "1"
    items = Item.find_all_by_merchant_id merchant_id
    assert_equal 15, items.size

    merchant_id = "2"
    items = Item.find_all_by_merchant_id merchant_id
    assert_equal 38, items.size

  end

  def test_it_returns_empty_for_nonexistant_merchant_id

    merchant_id = "blah"
    items = Item.find_all_by_merchant_id merchant_id
    assert items.empty?
  end

  def test_it_find_all_items_by_unit_price

    unit_price = "99028"
    items = Item.find_all_by_unit_price unit_price
    assert_equal 2, items.size

    unit_price = "98005"
    items = Item.find_all_by_unit_price unit_price
    assert_equal 1, items.size

  end

  def test_it_returns_empty_for_nonexistant_unit_price

    unit_price = "23589012301"
    items = Item.find_all_by_unit_price unit_price
    assert items.empty?
  end

  def test_it_find_all_items_by_description

    description = "A aut ab autem rerum voluptas. Facere qui rerum dolore architecto recusandae nesciunt enim. Est voluptatem labore dolor autem. Doloremque ea amet aut et animi doloribus. Aut distinctio quidem dolores officiis architecto."
    items = Item.find_all_by_description description
    assert_equal 1, items.size
  end

  def test_it_returns_empty_for_nonexistant_description

    description = "dadadad dadadad"
    items = Item.find_all_by_description description
    assert items.empty?
  end

  def test_it_finds_all_by_created_at
    date = "2012-03-27 14:54:09 UTC"
    items = Item.find_all_by_created_at date
    assert_equal 180, items.size
    assert_equal date, items.sample.created_at

    date = "2012-03-27 14:54:08 UTC"
    items = Item.find_all_by_created_at date
    assert_equal 234, items.size
    assert_equal date, items.sample.created_at
  end

  def test_returns_empty_array_with_non_existing_created_date
    merchant = "0"
    date = "1999-03-06 15:55:33 UTC"
    items = Item.find_all_by_created_at date
    assert_equal 0, items.size

  end

  def test_it_finds_all_by_updated_at
    date = "2012-03-27 14:53:59 UTC"
    items = Item.find_all_by_updated_at date
    assert_equal 170, items.size
    assert_equal date, items.sample.updated_at

    date = "2012-03-27 14:54:00 UTC"
    items = Item.find_all_by_updated_at date
    assert_equal 234, items.size
    assert_equal date, items.sample.updated_at
  end

  def test_returns_empty_array_with_non_existing_updated_date
    merchant = "0"
    date = "1999-03-06 15:55:33 UTC"
    items = Item.find_all_by_updated_at date
    assert_equal 0, items.size

  end
end