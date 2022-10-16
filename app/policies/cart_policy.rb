class CartPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
    #   scope.all
    # end
      if @user.has_role? :buyer
        scope.all
      else
        scope.where(content: '')
      end
    end
  end

  def show?
    # @user.has_role? :buyer
    # true
  end
