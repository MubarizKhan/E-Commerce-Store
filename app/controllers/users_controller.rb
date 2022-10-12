class UsersController < ApplicationController

  # rolify

  def new
    @user = User.new
  end

  def choose_role
    @user = current_user
    # if Product.where(user_id: current_user.id)
      # @user.add_role :seller# , Product.where(user_id: current_user.id)
    # end
  end

  def buyer
    current_user.add_role :buyer
  end

  def seller
    current_user.add_role :seller
  end


  def user_params
    params.require(:user).permit(:full_name, :display_picture, :email, {role_ids: []})
  end

end
