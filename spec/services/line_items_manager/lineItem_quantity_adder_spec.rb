def create_first_product
  Product.new(
    id: 12,
    user_id: 34,
    item_quantity: 10,
    item_price: 10
  )
end


def create_first_line_item
  # hitting DB here
  LineItem.new(
    quantity: 3,
    # total_line_item_price: 30,
    cart_id: 34,
    product_id: 12
  )
end



first_product = create_first_product
first_line_item = create_first_line_item

RSpec.describe LineItemsManager::LineItemQuantityAdder, 'call' do
  it 'check if result is not nil' do
    result = LineItemsManager::LineItemQuantityAdder.new(chosen_product: first_product, line_item: first_line_item).call
    expect(result).not_to eq nil
  end

  it 'check correct line_item price' do
    result = LineItemsManager::LineItemQuantityAdder.new(chosen_product: first_product, line_item: first_line_item).call
    expect(first_line_item.quantity).to be <= first_product.item_quantity
  end
end
