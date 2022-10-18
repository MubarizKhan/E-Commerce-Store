# frozen_string_literal: true

module OrdersManager
  class OrderManager
    def initialize(order:)
      @order = order
    end

    def call
      order!
      result = { order: order!, errors: @errors }
    end

    private

    def order!
      @order.line_items.each do |item|
        product = Product.find(item.product_id)
        product.item_quantity -= item.quantity

        if product.save && item.update(cart_id: nil)
          apply_coupon_discount!

        else
          @errors[product: product&.errors&.full_messages&.join(', ')]

          begin
            @errors[item: item.errors.full_messages.join(', ')]
          rescue StandardError
            nil
          end

        end
      end

      @order.completed!
    end

    def apply_coupon_discount!
      coupon = Coupon.find_by(coupon_name: @order.coupon_name)
      if coupon
        discounted_price = @order.order_amount - (@order.order_amount * coupon.discount)
        @order.update(order_amount: discounted_price)

      else
        @order

        begin
          @errors[coupon: coupon.errors.full_messages.join(', ')]
        rescue NoMethodError
          nil
        end
      end
    end
  end
end
