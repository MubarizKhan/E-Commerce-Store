# frozen_string_literal: true


class OrdersController < ApplicationController
  before_action :set_creation_order, only: %i[show active_order update order ]

  def index
    @orders = current_user.orders.all
    authorize @orders
  end

  def show
    # @order = Order.find(params[:id])
    @order_line_items = LineItem.where(order_id: @order.id)
    # authorize @order
  end

  def active_order
    # @order = Order.find(params[:id])
    @order_line_items = LineItem.where(order_id: @order.id)
  end

  def create
    Order.create(order_params.merge(user_id: current_user.id))
    redirect_to orders_path
  end

  def update
    # @order = Order.find(params[:id])
    @order.update(coupon_name: params[:order][:coupon_name])
  end

  def order

    price = OrdersManager::OrderManager.new(order: @order).call
    redirect_to order_path(@order.id)
  end

  private

  def order_params
    params.permit(:user_id)
  end

  def set_creation_order
    @order = Order.find(params[:id])
  end


end
