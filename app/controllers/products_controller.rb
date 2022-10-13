# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[show edit update]

  def index
    @products = Product.all
    @user = current_user

    authorize @products
  end

  def new
    @product = Product.new
    @user = current_user
    authorize @product
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
    @product = current_user.products.create(product_params)
    authorize @product

    if @product
      current_user.add_role :seller, @product

      current_user.remove_role :newuser if current_user.has_role? :newuser
      redirect_to root_path

    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :id, :cover_picture, :item_quantity, :first_name, :last_name, :item_price)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
