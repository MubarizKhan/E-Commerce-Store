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
multiple_prod_price_line_item_quantity = first_product.item_price * first_line_item.quantity

RSpec.describe LineItemsManager::LineItemPriceSetter, 'call' do
  it 'check if result is not nil' do
    result = LineItemsManager::LineItemPriceSetter.new(chosen_product: first_product, line_item: first_line_item).call
    expect(result).not_to eq nil
  end

  it 'check correct line_item price' do
    result = LineItemsManager::LineItemPriceSetter.new(chosen_product: first_product, line_item: first_line_item).call
    expect(first_line_item.total_line_item_price).to eq(multiple_prod_price_line_item_quantity)
  end
end


# def create_second_product
#   Product.new(
#     id: 13,
#     user_id: 34,
#     item_quantity: 10,
#     item_price: 20
#   )
# end

# def create_second_line_item
#   # hitting DB here
#   LineItem.new(
#     id: 13,
#     quantity: 4,
#     total_line_item_price: 40,
#     cart_id: 34
#   )
# end
