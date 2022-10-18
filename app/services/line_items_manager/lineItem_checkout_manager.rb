# frozen_string_literal: true

module LineItemsManager
  class LineItemCheckoutManager
    # splat vs double splat vs named parameters
    def initialize(order:, cart_id:)
      @order = order
      @cart = cart_id
    end

    def call
      result = checkout
    end

    private

    def checkout
      price_var = 0

      Cart.find(@cart).line_items.each do |item|
        price_var += item.total_line_item_price.to_d
        item.update(order_id: @order.id)
      end

      @order.update(order_amount: price_var)
      @order.in_progress!
    end
  end
end
