# frozen_string_literal: true

class CartsController < ApplicationController
  def show
    @cart = current_cart
    @line_items = current_user.cart.line_items
  end

  def destroy
    @cart = @current_cart
    session[:cart_id] = nil
    redirect_to root_path
  end
end
