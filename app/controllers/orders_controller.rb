# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_creation_order, only: %i[show active_order update order]

  def index
    @orders = current_user.orders.all
    authorize @orders
  end

  def show
    @order_line_items = @order.line_items
    authorize @order
  end

  def active_order
    # ditto
    @order_line_items = LineItem.where(order_id: @order.id)
  end

  def create
    Order.create(order_params.merge(user_id: current_user.id))
    # current_user.orders.create(order_params)
    redirect_to orders_path
  end

  def update
    @order.update(coupon_name: coupon_name)
  end

  def order
    service_order = OrdersManager::OrderManager.new(order: @order).call
    # price = service_order[:@order]
    redirect_to order_path(@order.id)#, alerts: service_order[:errors]
  end

  private

  def order_params
    params.permit(:user_id)
  end

  def set_creation_order
    @order = Order.find(params[:id])
  end

  def coupon_name
    params[:order][:coupon_name]
  end
end
