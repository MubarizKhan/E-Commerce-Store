class OrdersController < ApplicationController
  def new
    print "########################"
    print "######### NEW ORDER ###############"
    print "########################"
    print "########################"
    @order = Order.new


    # @line_item = @current_cart.line_items.find(params[:li_id])
    # print @line_item
    # print @current_cart.line_items
    # print params.inspect
    # print "<==============this is LIII"
    # print params[:item_id]
    # print "<==============this is order"
    # print "########################"
    # print "########################"
    redirect_to root_path
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
    @order = Order.new
    @order.user_id = current_user.id

    @line_item = @current_cart.line_items.find(params[:id])
    print @line_item.cart_id
    @line_item.order_id = @order.id


    print @line_item.order_id

    print params[:id]
  end

  def order_params
    params.require(:order).permit(:user_id)
  end

  # end
end
