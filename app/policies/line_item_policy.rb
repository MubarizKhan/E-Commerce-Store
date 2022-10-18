# frozen_string_literal: true

class LineItemPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if @user.has_role? :buyer
        scope.all
      else
        scope.where(content: '')
      end
    end
  end

  def create?
    # prod = Product.find(@line_item.product_id)
    # @line_item.product_id
    @user.has_role? :buyer

    # if @prod.user_id? :@user.id
    # false
    # else
    # true
    # end
    # if @prod.user_id == @user.id
    # false
    # else
    # @user.has_role? :buyer

    # scope.all
    # end
  end
end
