class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception
  before_action :current_cart

  protected

  def configure_permitted_parameters
    attributes = [:first_name,:last_name, :email, :avatar]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  private
  def current_cart
    if session[:cart_id]
      # print "============================"
      # print "===========CARD ID EXISTS================="
      print session[:cart_id]
      # print "=========^^^^^==================="
      cart = Cart.find_or_create_by(user_id: current_user.id)

      # print"======VV====="
      print cart
      # print"======VV====="

      if cart.present?
        # print "/////////////////"
        print cart.present?
        # print "/////////////////"
        @current_cart = cart
        @current_cart.user_id = current_user.id
        # print "============================"
        # print "============THIS IS CURRENT CART================"
        print @current_cart.id
        # print "============================"
      else
        # print "==========CART not present =================="
        session[:cart_id] = nil
      end
      # byebug
    end

  if current_user
    if session[:cart_id] == nil
      # print "============================"
      # print "============================"
      # print "session[:cart_id] is NULL"
      # print "============================"
      @current_cart = Cart.create
      @current_cart.user_id = current_user. id
      session[:cart_id] = current_user.id
      end
    end
  end
end
