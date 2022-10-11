# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.all
  end

  def show

    @order = current_user.orders.last
    @order_line_items = LineItem.where(order_id: @order.id)
  end

  def create

    if Order.where(status: 0).any?
      @order = Order.where(status: "newly_created")

    elsif Order.where(status: 1).any?
      @order = Order.where(status: 1)

    else
      @order = Order.create(order_params.merge(user_id: current_user.id))
    end

    redirect_to orders_path
  end


  def update

    @order = Order.find_by(user_id: current_user.id)
    @order.update(coupon_name: params[:order][:coupon_name])

  end

  def checkout

    @order = Order.find_by(user_id: current_user.id, status: "adding_items")
    @coupon = Coupon.find_by(coupon_name: @order.coupon_name)
    price_var = 0

    LineItem.where(order_id: @order.id).all.each do |c|
      price_var += c.total_line_item_price
      p =  Product.find(c.product_id)
      p.item_quantity -= c.quantity
      print p.item_quantity
      p.save

    end

    @line_items = LineItem.where(order_id: @order.id).all

    if @coupon
      @order.order_amount = price_var * (1 - @coupon.discount)
    else
      @order.order_amount = price_var
    end

    @order.completed!
    @order.save
    @line_items.destroy_all
    create

  end

  def order_params
    params.permit(:user_id)
  end
end
