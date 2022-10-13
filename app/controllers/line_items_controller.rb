# frozen_string_literal: true

class LineItemsController < ApplicationController
  before_action :set_line_item, only: %i[remove_lineItem_from_order destroy]
  before_action :set_line_item_product, only: %i[reduce_quantity add_quantity]
  before_action :set_line_item_by_product, only: %i[reduce_quantity add_quantity]

  def create
    @line_item = @current_cart.line_items.find_or_create_by(lineItem_params)
    print "PARAMS HERE"
    print "8888888888888888888888888"
    print params.inspect
    set_total_line_item_price(@line_item, Product.find(@line_item.product_id))
  end

  def update_orderNum
    @order = if Order.where(user_id: current_user.id, status: 0).any?
               Order.where(user_id: current_user.id, status: 0)

             elsif Order.where(user_id: current_user.id, status: 1).any?

               Order.where(user_id: current_user.id, status: 1)

             else

               Order.create(user_id: current_user.id)
             end

    @line_item = @current_cart.line_items.find(params[:id])

    # if @order.is_a?(Array)
      if @order.ids[0]
      @line_item.update(order_id: @order.ids[0])
      @order[0].adding_items!
      @order[0].save

      else
      @line_item.update(order_id: @order.id)
      @order.adding_items!
      @order.save

#
    # else
      # @line_item.update(order_id: @order.ids)
      # @order[0].adding_items!
      # @order[0].save
    end

    @line_item.save
    redirect_to carts_path
  end

  def set_total_line_item_price(line_item, chosen_product)
    @line_item = line_item
    @line_item.total_line_item_price = line_item.quantity * chosen_product.item_price
    @line_item.save
  end

  def add_quantity
    @line_item.quantity += 1
    set_total_line_item_price(@line_item, @chosen_product)
    @line_item.save

    respond_to do |format|
      format.html { redirect_to root_path, notice: '@line_item was successfully destroyed.' }
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

    @line_item.save
    respond_to do |format|
      format.html { redirect_to root_path, notice: '@line_item was successfully destroyed.' }
      format.js { render layout: false }
    end
  end

  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: '@line_item was successfully destroyed.' }
      format.js { render layout: false }
    end
  end

  def remove_lineItem_from_order
    @line_item.order_id = 0
    @line_item.save

    respond_to do |format|
      format.html { redirect_to root_path, notice: '@line_item destroyed from order' }
      format.js { render layout: false }
    end
  end

  private

  def lineItem_params
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
end
