class UsersController < ApplicationController

  def new
    @user = User.new
  end

  # def destroy
  #   @user = User.find(params[:id])
  #   @user.destroy
  #   respond_to do |format|
  #     format.html { redirect_to users_path, notice: 'User was successfully destroyed.' }
  #     format.json { head :no_content }
  #     # format.js
  #     # { render :layout => false }
  #   end
  end

  def user_params
    params.require(:user).permit(:full_name, :display_picture, :email)
  end

end
