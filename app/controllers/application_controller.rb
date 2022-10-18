# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protect_from_forgery with: :exception
  before_action :current_cart

  include Pundit::Authorization

  protected

  def configure_permitted_parameters
    attributes = %i[first_name last_name email avatar]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  private

  def user_not_authorized
    # print 20 * '-'
    print '%%%%%% NOT AUTHORIZED $$$$$$$$'
    print '%%%%%% NOT AUTHORIZED $$$$$$$$'
    print '%%%%%% NOT AUTHORIZED $$$$$$$$'
    print '%%%%%% NOT AUTHORIZED $$$$$$$$'
    # flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to root_path, notice: 'You are not authorized to perform this action.' # (fallback_location: root_path)
    # end
  end

  def current_cart
    if session[:cart_id]
      print session[:cart_id]

      if current_user

        cart = Cart.find_or_create_by(user_id: current_user.id)
        # cart = current_user.cart.find_or_create_by

        if cart.present?
          @current_cart = cart
          @current_cart.user_id = current_user.id
          # @current_cart.user_id = current_user.id

        else
          session[:cart_id] = nil
        end
      end
    end

    if current_user && session[:cart_id].nil?
      @current_cart = Cart.create
      @current_cart.user_id = current_user.id
      session[:cart_id] = current_user.id
    end
  end
end
