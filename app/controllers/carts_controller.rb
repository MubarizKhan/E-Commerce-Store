class CartsController < ApplicationController
  def index
    print "--------------------"
    print "--------------------"
    print "---------INDEX CART-----------"
    print "--------------------"
    print "--------------------"
    # @cart = Cart.new(user_id: current_user.id)
    # @cart.user_id = current_user.id
    # @cart.save
    @cart = current_cart
    # redirect_to root_path
  end

  # end

  def show
    @cart = current_cart
  end

  def destroy
    @cart = @current_cart
    @cart.destroy
    session[:cart_id] = nil
    redirect_to root_path
  end

end
