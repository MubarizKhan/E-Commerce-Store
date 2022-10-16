
module OrdersManager

  class OrderManager

    def initialize(order:)
      @order = order
      # @cart = cart_id
    end

    def call
      result = order
    end

    private

    def order
      LineItem.where(order_id: @order.id).all.each do |item|

        product = Product.find(item.product_id)
        product.item_quantity -= item.quantity
        product.save

        item.update(cart_id: nil)
      end
      coupon_discount
      @order.completed!
    end

    def coupon_discount
      @coupon = Coupon.find_by(coupon_name: @order.coupon_name)
      if @coupon
        discounted_price = @order.order_amount - (@order.order_amount * @coupon.discount)
        @order.update(order_amount: discounted_price)
      else
        @order
      end

    end

  end
end
