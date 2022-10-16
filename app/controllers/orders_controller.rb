# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.all
    authorize @orders
  end

  def show

    @order = Order.find(params[:id])
    @order_line_items = LineItem.where(order_id: @order.id)
    # authorize @order
  end

  def active_order
    @order = Order.find(params[:id])
    # @order = current_user.orders.last
    @order_line_items = LineItem.where(order_id: @order.id)
  end

  def create
    Order.create(order_params.merge(user_id: current_user.id))
    redirect_to orders_path
  end

  def update
    @order = Order.find(params[:id])
    @order.update(coupon_name: params[:order][:coupon_name])
  end

  def order
    # @order = Order.find_by(user_id: current_user.id, status: 'adding_items')
    @order = Order.find(params[:id])
    price = OrdersManager::OrderManager.new(order: @order).call
    redirect_to order_path(@order.id)
    # render :show
  end

  def order_params
    params.permit(:user_id)
  end
end
