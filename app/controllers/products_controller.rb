class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.all
    @user = current_user
  end

  def new
  @product = Product.new
  end

  def show
    @product = current_user.products.find(params[:id])
    # if @product
  end


  def edit
    begin
    rescue RecordNotFound => e
      redirect_to root_path
      puts "===================================="
      puts "===================================="
      puts " You are not allowed, as u are not the creater of this file"
      puts "===================================="
      puts "===================================="
    end
    @product = current_user.products.find(params[:id])
  end

  def update
    @product = current_user.products.find(params[:id])
    begin
      rescue RecordNotFound => e
        redirect_to root_path
        puts "===================================="
        puts "===================================="
        puts " You are not allowed, as u are not the creater of this file"
        puts "===================================="
        puts "===================================="
    end

    puts "===================================="
    puts "===================================="
    puts @product.name
    puts "===================================="
    puts "================================>===="
    if @product.update(product_params)
      puts @product.name
      redirect_to root_path
    else
      render :edit
    end
  end


  def create
    # @article.paragraph.name =  ">"

    @product = current_user.products.create(product_params)
    print('c here')
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

end

  # def destroy
  #   @article = Article.find(params[:id])
  #   @article.destroy
  #   @article.destroy if @article.present?
  #   redirect_to root_path
  # end
  # Using Strong Parameters


  private

  # Submitted form data is put into the params Hash, alongside captured route parameters.
  # Thus, the create action can access the submitted title via params[:article][:title] and the submitted body via params[:article][:body].
  #  We could pass these values individually to Article.new, but that would be verbose and possibly error-prone.
  # And it would become worse as we add more fields.

  # Instead, we will pass a single Hash that contains the values.
  # However, we must still specify what values are allowed in that Hash.
  # Otherwise, a malicious user could potentially submit extra form fields and overwrite private data.
  # In fact, if we pass the unfiltered params[:article] Hash directly to Article.new,
  # Rails will raise a ForbiddenAttributesError to alert us about the problem.
  # So we will use a feature of Rails called Strong Parameters to filter params. Think of it as strong typing for params.

  def product_params
    params.require(:product).permit(:name, :id, :cover_picture,:item_quantity, :first_name, :last_name)
  end
# end
# end




