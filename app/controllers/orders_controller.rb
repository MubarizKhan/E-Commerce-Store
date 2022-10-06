class OrdersController < ApplicationController
  def index
    @order = Order.find_by(user_id: current_user.id)
    @order_line_items = LineItem.where(order_id: @order.id)
    # ;l;l;l
  end

  def create
    if Order.find_by(user_id: current_user.id)
      print "########################"
      print "###### In IF #########"
    else
      print "###### In else #########"
      Order.create(user_id: current_user.id)
    end
    redirect_to root_path
  end

  def add_to_order
    @order = Order.find_by(user_id: current_user.id)
    @line_item = @current_cart.line_items.find(params[:id])
    # print @line_item.cart_id
    @line_item.order_id = @order.id
    # print @line_item.order_id
    @line_item.save
    # print params[:id]
  end

  def update
    @order = Order.find_by(user_id: current_user.id)
    @order.coupon_name = params[:order][:coupon_name]
    # @order.save

    @coupon = Coupon.find_by(coupon_name: params[:order][:coupon_name])
    # print "#####################"
    # print "#####################"
    # print @coupon.coupon_name
    # print "#####################"
    # print "#####################"

    # print params.inspect
    @order_line_items = LineItem.where(order_id: @order.id)
    price_var = 0
    ctr = 0
    LineItem.where(order_id: @order.id).all.each do |c|
      print ">>>>>>>> >>>"
      price_var += c.total_line_item_price
    end
    print price_var * (1 - @coupon.discount)
    @order.order_amount = price_var * (1 - @coupon.discount)
    @order.save
  end

  def order_params
    params.require(:order).permit(:user_id)
  end
end
