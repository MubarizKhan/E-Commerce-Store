class OrdersController < ApplicationController
  def new
    print "########################"
    print "######### NEW ORDER ###############"
    print "########################"
    print "########################"

    print "LLLLLLLLLL"

    # @line_item = @current_cart.line_items.find(params[:li_id])
    # print @line_item
    print @current_cart.line_items
    print params.inspect
    print "<==============this is LIII"
    print params[:item_id]
    print "<==============this is order"
    print "########################"
    print "########################"
    redirect_to root_path
  end

  def show
    @order = Order.new
    @order.user_id = current_user.id

    @line_item = @current_cart.line_items.find(params[:id])
    print @line_item.cart_id
    @line_item.order_id = @order.id


    print @line_item.order_id

    print params[:id]





  end
end
