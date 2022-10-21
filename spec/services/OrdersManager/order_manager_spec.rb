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
    id: 888,
    user_id: 34,
    order_amount: nil,
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
  Coupon.find_by(coupon_name: "DevnTech")
end

  cart = create_cart
  order = create_order
  first_line_item = create_first_line_item
  second_line_item = create_second_line_item
  user = create_user
  coupon = find_coupon



RSpec.describe OrdersManager::OrderManager, 'call' do
  it 'check if result is not nil' do
    result = OrdersManager::OrderManager.new(order: order).call
    expect(result).not_to eq nil
  end

  it 'check order_status is completed or not' do
    result = OrdersManager::OrderManager.new(order: order).call
    expect(order.status).to eq "completed"
  end

  # it 'check order price reduction w/ coupon' do

  #   result = OrdersManager::OrderManager.new(order: order).call
  #   without_coupon = order.order_amount

  #   # with_coupon = order.order_amount - (order.order_amount * coupon.discount)
  #   order.update(coupon_name: "DevnTech")

  #   print without_coupon
  #   print "(///)(////)(////)" * 5
  #   print with_coupon
  #   # print order.order_amount
  #   # result_with_coupon = OrdersManager::OrderManager.new(order: order).call

  #   expect(order.order_amount).to eq with_coupon

  # end
end
