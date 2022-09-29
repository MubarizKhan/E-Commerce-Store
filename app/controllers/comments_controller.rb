class CommentsController < ApplicationController

  def index
    @product = current_user.products.find(params[:product_id])
    # @comment = @product.comments.newx
  end

  def create
    # if user_signed_in?
      # @product = Product.find(params[:product_id])
      @product = current_user.products.find(params[:product_id])
      if @product
        print "---------product is true---------------"
        print @product
        print "------------------------"
        # user_id: current_user.id, article_id: @article.id)
        # @product = current_user.products.find(params[:product_id])
        @comment = @product.comments.create(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
          print "---------comment is saved!---------------"
          redirect_to product_path(@product)
        else
          print "---------comment NOT saved!---------------"
          print @comment
          print current_user.id
          # print :body
          # prkmkint "---------------------------"
        end
      else
        redirect_to root_path
    # redirect_to product_path(@product) #article_path(@article)
    end
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
    params.require(:comment).permit(:body ,:user_id, :product_id)
  end

end
