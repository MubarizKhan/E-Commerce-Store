class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def choose_role
    @user = current_user
    # if Product.where(user_id: current_user.id)
      # @user.add_role :seller# , Product.where(user_id: current_user.id)
    # end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      params.inspect
      redirect_to root_path
    else
      render :choose_role, status: :unprocessable_entity
    end

  end


  def user_params
    params.require(:user).permit(:full_name, :display_picture, :email, {role_ids: []})
  end

end
