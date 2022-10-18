# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: %i[show active_order update place]
  before_action :set_line_items, only: %i[show active_order]

  def index
    @completed_orders = authorize current_user.orders.completed_orders
    @current_orders = authorize current_user.orders.current
  end

  def show
    authorize @order
  end

  def active_order; end

  def create
    # Order.create(order_params.merge(user_id: current_user.id))
    current_user.orders.create(order_params)
    redirect_to orders_path
  end

  def update
    @order.update(coupon_name:)
    # @order.update(order_amount: coupon_name(@order))
    # coupon_name(@order)
  end

  def place
    # @coupon = Coupon.find_by(coupon_name: @order.coupon_name)
    service_order = OrdersManager::OrderManager.new(order: @order).call

    print '[{{{{{{{{{{{{{'
    print '[{{{{{{{{{{{{{'
    print(service_order[:errors])
    print '[{{{{{{{{{{{{{'
    print '[{{{{{{{{{{{{{'

    if service_order
      redirect_to order_path(@order.id), alert: service_order[:errors]
    else
      render json: service_order.errors, alert: service_order[:errors]
    end
  end

  private

  def order_params
    params.permit(:user_id)
  end

  def set_order
    @order = Order.find(params[:id])
  end

  # def coupon_name(order)
  #   @coupon = Coupon.find_by(coupon_name: params[:order][:coupon_name])

  #   if @coupon
  #     order.calculate_discount(@coupon)
  #   else

  #     begin
  #       @errors[coupon: coupon.errors.full_messages.join(', ')]
  #     rescue NoMethodError
  #       nil
  #     end

  #   end
  # print "{}{}{}" * 20
  # print params.inspect
  # print "{}{}{}" * 20
  # end

  def coupon_name
    params[:order][:coupon_name]
  end

  def set_line_items
    @order_line_items = @order.line_items
  end
end
