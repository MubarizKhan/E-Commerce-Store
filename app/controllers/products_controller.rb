class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[show edit update]

  def index
    @products = Product.all
    @user = current_user
  end

  def new
    @product = Product.new
  end

  def show; end

  def edit; end

  def update

    if @product.update(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end


  def create

    if current_user.products.create(product_params)
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :id, :cover_picture,:item_quantity, :first_name, :last_name, :item_price)
  end

  def set_product
    @product = Product.find(params[:id])
  end

end




