# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :remove_newuser_role, only: %i[seller buyer]

  def new
    @user = User.new
  end

  def choose_role; end

  def buyer
    current_user.add_role :buyer
    redirect_to root_path
  end

  def seller
    current_user.add_role :seller
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :display_picture, :email, { role_ids: [] })
  end

  def remove_newuser_role
    current_user.remove_role :newuser if current_user.has_role? :newuser
  end
end
