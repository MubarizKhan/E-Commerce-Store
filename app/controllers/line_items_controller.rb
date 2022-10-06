class LineItemsController < ApplicationController
  def index
    print "--------------------"
    print "--------------------"
    print "---------Line Items---"
    print "--------------------"
    print "--------------------"
  end

  def new
    @line_item = LineItem.new
  end

  def create
    chosen_product = Product.find(params[:product_id])
    current_cart = @current_cart
    if current_cart.products.include?(chosen_product)
      # Find the line_item with the chosen_product
      @line_item = current_cart.line_items.find_by(product_id: chosen_product)
      # Iterate the line_item's quantity by one
      if @line_item.quantity.nil?
        @line_item.quantity = 1
      end
      @line_item.quantity += 1

    else
      @line_item = LineItem.new
      @line_item.cart = current_cart
      @line_item.product = chosen_product
      @line_item.quantity = 1
    end
    # Save and redirect to cart show path
    @line_item.total_line_item_price = @line_item.quantity * chosen_product.item_price
    @line_item.save
  end

  def update_orderNum
    @order = Order.find_by(user_id: current_user.id)
    print @order.id
    # @order.user_id = current_user.id
    @line_item = @current_cart.line_items.find(params[:id])

    if @line_item.order_id.nil?
      @line_item.order_id = @order.id
    end
    @line_item.order_id = @order.id

    @line_item.save
    redirect_to root_path
  end

  def add_quantity
    # redirect_to root_path
    chosen_product = Product.find(params[:id])
    current_cart = @current_cart

    @line_item = current_cart.line_items.find_by(product_id: chosen_product)
    @line_item.quantity += 1
    print "//////////////////////////////"
    print "//////////////////////////////"
    print "/////// ADDED QUANTITY  ///////"
    # print @line_item.quantity
    @line_item.total_line_item_price = @line_item.quantity * chosen_product.item_price
    @line_item.save

    respond_to do |format|
      format.html { redirect_to root_path, notice: '@line_item quantity successfully updated.' }
      format.js { render :layout => false }
    end


  end

  def reduce_quantity
    chosen_product = Product.find(params[:id])
    current_cart = @current_cart
    @line_item = current_cart.line_items.find_by(product_id: chosen_product)
    @line_item.quantity -= 1
    @line_item.save
    print "/////// Reduced QUANTITY  ///////"
    print @line_item.quantity

    if @line_item.quantity == 0
      @line_item.destroy
    else
      @line_item.total_line_item_price = @line_item.quantity * chosen_product.item_price
    end

    respond_to do |format|
      format.html { redirect_to root_path, notice: '@line_item was successfully destroyed.' }
      format.js { render :layout => false }
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: '@line_item was successfully destroyed.' }
      format.js { render :layout => false }
    end
  end

  def remove_lineItem_from_order
    @line_item = LineItem.find(params[:id])
    print @line_item.order_id
    @line_item.order_id = 0
    @line_item.save

    respond_to do |format|
      format.html { redirect_to root_path, notice: '@line_item destroyed from order' }
      format.js { render :layout => false }
    end
  end

  private

  def lineItem_params
    params.require(:line_items).permit(:cart_id, :product_id, :quantity)
  end
end

