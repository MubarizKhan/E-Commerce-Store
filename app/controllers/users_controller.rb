class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def user_params
    params.require(:user).permit(:full_name, :display_picture, :email)
  end

end
