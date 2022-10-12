class LineItemsController < ApplicationController
  before_action :set_line_item, only: %i[remove_lineItem_from_order destroy]
  before_action :set_line_item_product, only: %i[reduce_quantity add_quantity]
  before_action :set_line_item_by_product, only: %i[reduce_quantity add_quantity]

  def create
    @line_item = @current_cart.line_items.find_or_create_by(lineItem_params)
    set_total_line_item_price(@line_item, Product.find(@line_item.product_id))
  end

  def update_orderNum
    # @order = Order.all.where(user_id: current_user.id)
    if current_user.orders.last
      @order = current_user.orders.last

    else
      @order = Order.find_or_create_by(user_id: current_user.id)

    end

    @line_item = @current_cart.line_items.find(params[:id])
    @line_item.update(order_id: @order.id)
    @order.adding_items!
    @order.save
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
