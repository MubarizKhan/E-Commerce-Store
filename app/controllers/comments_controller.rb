# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_product, only: %i[create edit update destroy]
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = @product.comments.create(comment_params.merge(user_id: current_user.id))
    respond_to do |format|
      format.html { redirect_to product_path(@product), notice: '@comment successfully created.' }
      format.js { render layout: false }
    end
  end

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
        format.html { redirect_to root_path, notice: '@comment was successfully destroyed.' }
        format.js { render layout: false }
      end
    else
      @comment.errors.full_messages.join('/n')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :product_id)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_comment
    @comment = @product.comments.find(params[:id])
  end
end
