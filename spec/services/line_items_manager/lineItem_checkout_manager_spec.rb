def create_user
  User.create(id: 34)
end


def create_cart
  # hitting DB here
  Cart.find_by(
    id: 38,
    user_id: 34

  )
end


def create_order
  # hitting DB here
  Order.new(
    id: 999,
    user_id: 34,
    order_amount: nil
  )
end

def create_first_line_item
  # hitting DB here
  LineItem.new(
    quantity: 3,
    total_line_item_price: 30,
    cart_id: 34
  )
end

def create_second_line_item
  # hitting DB here
  LineItem.new(
    quantity: 4,
    total_line_item_price: 40,
    cart_id: 34
  )
end


  cart = create_cart
  order = create_order
  first_line_item = create_first_line_item
  second_line_item = create_second_line_item
  user = create_user

  RSpec.describe LineItemsManager::LineItemCheckoutManager, 'call' do
  it 'calculates order_amount & updates order_status' do

    result = LineItemsManager::LineItemCheckoutManager.new(order: order, cart_id: cart.id).call

    expect(result).not_to eq nil
    expect(order.status).to eq "in_progress"


  end

  it 'fails when order status is not in_progress' do
    result = LineItemsManager::LineItemCheckoutManager.new(order: order, cart_id: cart.id).call
    expect(order.status).to eq "in_progress"
  end

  it 'fails if line_items order_id; is not of order' do
    result = LineItemsManager::LineItemCheckoutManager.new(order: order, cart_id: cart.id).call
    cart.line_items.each do |item|
      expect(item.order_id).to eq order.id
    end
  end

  it 'fails when order belongs to someother user' do
    result = LineItemsManager::LineItemCheckoutManager.new(order: order, cart_id: cart.id).call
    print order.user_id
    # print '---'  * 20
    expect(order.user_id).to eq user.id
  end

  it 'fails when cart belongs to someother user' do
    result = LineItemsManager::LineItemCheckoutManager.new(order: order, cart_id: cart.id).call
    print cart.user_id
    expect(cart .user_id).to eq user.id
  end

  it 'fails if order_amount not updated properly' do
    result = LineItemsManager::LineItemCheckoutManager.new(order: order, cart_id: cart.id).call

    price = 0
    cart.line_items.each do |item|
      price += item.total_line_item_price
    end

    expect(order.order_amount).to eq price

  end


end
