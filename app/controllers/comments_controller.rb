# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[create edit update destroy]
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = @product.comments.create(comment_params.merge(user_id: current_user.id))

    respond_to do |format|
      format.html { redirect_to product_path(@product), notice: 'Commented!' }
      format.js { render layout: false } # read about it.
      # format.js
    end
  end

  def new; end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Comment removed!' }
        format.js { render layout: false }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, notice: @comment.errors.full_messages.join('/n') }
        format.js { render layout: false }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :product_id) # no need for user id
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_comment
    @comment = @product.comments.find(params[:id])
  end
end
