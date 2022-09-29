class CommentsController < ApplicationController

  def new
    @product = current_user.products.find(params[:product_id])

  end
  def create
    # if use_signed_in?
    @product = current_user.products.find(params[:product_id])
    @comment = @product.comments.create(comment_params)
    @comment.save
    redirect_to product_path(@product) #article_path(@article)
    # end
  end

  # def edit
  #   @product = current_user.products.find(params[:id])
  #   @comment = @product.comments.find(params[:product_id])
  # end

  # def update
  #   @product = current_user.products.find(params[:product_id])
  #   @comment = @product.comments.find(params[:id])

  #   if @comment.update(comment_params)
  #     flash[:notice] = 'You updated your comment!'
  #     @comment.save
  #     redirect_to root_path
  #   else
  #     render :edit
  #   end
  # end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
