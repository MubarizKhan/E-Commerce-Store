class CartsController < ApplicationController
  def index
    @cart = current_cart
  end

  def show
    @cart = current_cart
  end

  def destroy
    @cart = @current_cart
    session[:cart_id] = nil
    redirect_to root_path
  end

end
