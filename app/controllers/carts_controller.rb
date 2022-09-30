class CartsController < ApplicationController
  def index
    print "--------------------"
    print "--------------------"
    print "---------INDEX CART-----------"
    print "--------------------"
    print "--------------------"
    @cart = Cart.new(user_id: current_user.id)
    @cart.user_id = current_user.id
    @cart.save
    redirect_to root_path
  end


end
