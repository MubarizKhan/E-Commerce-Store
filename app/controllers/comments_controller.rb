class CommentsController < ApplicationController

  def index
    @product = current_user.products.find(params[:product_id])
    # @comment = @product.comments.newx
  end

  def create

      @product = current_user.products.find(params[:product_id])
      @comment = @product.comments.create(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
        print "---------comment is saved!---------------"
        # redirect_to product_path(@product)
      end
      respond_to do |format|
        format.html { redirect_to product_path(@product), notice: '@line_item quantity successfully updated.' }
        # format.json { head :no_content }
        format.js { render :layout => false }
      end
  end

  def edit
    print '---------------------IN EDITT-------------------'
    print '---------------------IN EDITT-------------------'
    print '---------------------IN EDITT-------------------'
    @product = current_user.products.find(params[:id])
    @comment = @product.comments.find(params[:product_id])
  end

  def update
    print '---------------------IN UPDATE-------------------'
    print '---------------------XXXXXXXX-------------------'
    print '---------------------XXXXXXXX-------------------'
    @product = current_user.products.find(params[:product_id])
    @comment = @product.comments.find(params[:id])

    if @comment.update(comment_params)
      flash[:notice] = 'You updated your comment!'
      @comment.save
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @product = current_user.products.find(params[:id])
    @comment = @product.comments.find(params[:product_id])
    # @user = User.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: '@comment was successfully destroyed.' }
      # format.json { head :no_content }
      format.js { render :layout => false }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body ,:user_id, :product_id)
  end

end
