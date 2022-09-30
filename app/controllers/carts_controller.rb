class CartsController < ApplicationController
  def index
    print "--------------------"
    print "--------------------"
    print "---------INDEX CART-----------"
    print "--------------------"
    print "--------------------"
    @cart = Cart.new(user_id :current_user:id)
  end
end
