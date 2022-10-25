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
  Order.find_or_create_by(
    id: 888,
    user_id: 34,
    order_amount: 70,
    status: "in_progress"
  )
end

def create_first_line_item
  # hitting DB here
  LineItem.new(
    quantity: 3,
    total_line_item_price: 30,
    cart_id: 34,
    order_id: 888
  )
end

def create_second_line_item
  # hitting DB here
  LineItem.new(
    quantity: 4,
    total_line_item_price: 40,
    cart_id: 34,
    order_id: 888
  )
end

def find_coupon
  Coupon.find_by(coupon_name: "Pak14")
end

  user = create_user
  cart = create_cart
  order = create_order
  first_line_item = order.line_items.find_or_create_by(product_id: 106, cart_id: cart.id, total_line_item_price: 100)
  second_line_item = order.line_items.find_or_create_by(product_id: 108, cart_id: cart.id, total_line_item_price: 800)
  coupon = find_coupon



RSpec.describe OrdersManager::OrderManager, 'call' do
  # in progress


  it 'check if result is not nil' do
    result = OrdersManager::OrderManager.new(order: order).call
    expect(result).not_to eq nil
  end

  it 'check order_status is completed or not' do
    result = OrdersManager::OrderManager.new(order: order).call
    expect(order.status).to eq "completed"
  end


  it 'check order price reduction w/ coupon' do

    without_coupon = order.order_amount
    test_with_coupon = order.order_amount - (order.order_amount * coupon.discount)
    order.update(coupon_name: "Pak14")

    result_with_coupon = OrdersManager::OrderManager.new(order: order).call
    # print result_with_coupon[:order]
    expect(order.order_amount).to eq(test_with_coupon)
  end


  it 'check line_item cart id to be nil' do
    result = OrdersManager::OrderManager.new(order: order).call

    order.line_items.each do |item|
      expect(item.cart_id).to eq(nil)
    end
  end

end
