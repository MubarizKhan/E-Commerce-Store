class LineItemsController < ApplicationController
  def index
    print "--------------------"
    print "--------------------"
    print "---------Line Items-----------"
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
    end
    # Save and redirect to cart show path
    @line_item.save
    #   redirect_to cart_path(current_cart)
    # redirect_to cart_path(@current_cart.id)
    print "//////////////////////////////"
    print "//////////////////////////////"
    print "/////// ADDED TO CART  ///////"
    print "//////////////////////////////"
    print "//////////////////////////////"
  end


  private

  def lineItem_params
    params.require(:line_items).permit(:cart_id, :product_id, :quantity)
  end
end

