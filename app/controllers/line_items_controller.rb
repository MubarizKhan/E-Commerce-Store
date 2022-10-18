# frozen_string_literal: true

class LineItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_line_item, only: %i[remove_lineItem_from_order destroy]
  before_action :set_line_item_product, only: %i[reduce_quantity add_quantity]
  before_action :set_line_item_by_product, only: %i[reduce_quantity add_quantity]
  before_action :set_creation_product, only: %i[create]

  def create
    # line_item_params
    @line_item = authorize @current_cart.line_items.find_or_create_by(line_item_params)
    LineItemsManager::LineItemPriceSetter.new(
      chosen_product: @chosen_product,
      line_item: @line_item
    ).call

    redirect_to carts_path
  end

  def add_quantity
    # @line_item.increment_by_1!
    LineItemsManager::LineItemQuantityAdder.new(
      chosen_product: @chosen_product, line_item: @line_item
    ).call # , quantity: line_item_params[:quantity]

    price = LineItemsManager::LineItemPriceSetter.new(
      chosen_product: @chosen_product,
      line_item: @line_item
    ).call

    respond_to do |format|
      format.html { redirect_to root_path, notice: '@line_item was successfully updated.' }
      format.js { render layout: false }
    end
  end

  def reduce_quantity
    @line_item.quantity -= 1

    if @line_item.quantity.zero?
      @line_item.destroy
    else
      set_total_line_item_price(@line_item, @chosen_product)
    end

    # @line_item.save!
    # new_arr = arr.truncate
    # arr
    # new_arr
    # arr.truncate!
    # arr
    if @line_item.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: '@line_item was successfully reduced.' }
        format.js { render layout: false }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, notice: line_item.errors.full_messages }
        format.js { render layout: false }
      end
    end
  end

  def destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: '@line_item was successfully destroyed.' }
      format.js { render layout: false }
    end
  end

  def checkout
    @order = Order.find_or_create_by(user_id: current_user.id, status: :in_progress)
    result = LineItemsManager::LineItemCheckoutManager.new(order: @order, cart_id: @current_cart.id).call
    redirect_to active_order_path(@order.id)
  end

  # def remove_lineItem_from_order
  #   @line_item.order_id = nil
  #   @line_item.save

  #   respond_to do |format|
  #     format.html { redirect_to root_path, notice: '@line_item destroyed from order' }
  #     format.js { render layout: false }
  #   end
  # end

  private

  def line_item_params
    params.permit(:cart_id, :product_id, :quantity)
  end

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def set_line_item_product
    @chosen_product = Product.find(params[:id])
  end

  def set_line_item_by_product
    @line_item = @current_cart.line_items.find_by(product_id: @chosen_product)
  end

  def set_creation_product
    @chosen_product = Product.find(params[:product_id])
  end
end

# def update_orderNum
#   @line_item = @current_cart.line_items.find(params[:id])

#   if current_user.orders.find_by(status: 1)
#     @order = current_user.orders.find_by(status: 1)

#   else
#     @order = current_user.orders.create
#   end

#   @line_item.update(order_id: @order.id)
#   @order.adding_items!
#   @order.save
#   @line_item.save
#   redirect_to carts_path
# end
