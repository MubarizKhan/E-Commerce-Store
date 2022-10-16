
module LineItemsManager

  class LineItemCheckoutManager

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

      LineItem.where(cart_id: @cart).all.each do |item|
        price_var += item.total_line_item_price
        item.update(order_id: @order.id)

        # p = Product.find(c.product_id)
        # p.item_quantity -= c.quantity
        # print p.item_quantity
        # p.save
        # print @order.id
      end
      @order.update(order_amount: price_var)
      @order.adding_items!
      # @line_items = LineItem.where(order_id: @order.id).all
      # @order.completed!
      # @order.save
    end
  end
end
