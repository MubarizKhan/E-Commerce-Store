# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception
  before_action :current_cart

  protected

  def configure_permitted_parameters
    attributes = %i[first_name last_name email avatar]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  private

  def current_cart
    if session[:cart_id]
      print session[:cart_id]
      cart = Cart.find_or_create_by(user_id: current_user.id)
      # print cart
      if cart.present?
        # print cart.present?
        @current_cart = cart
        @current_cart.user_id = current_user.id
      else
        session[:cart_id] = nil
      end
    end

    if current_user && session[:cart_id].nil?
      @current_cart = Cart.create
      @current_cart.user_id = current_user.id
      session[:cart_id] = current_user.id
    end
  end


end
