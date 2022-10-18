# frozen_string_literal: true

class OrderPolicy < ApplicationPolicy
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

  def index?
    @user.has_role? :buyer
  end

  def show?
    @user.has_role? :buyer
  end

  def create?
    @user.has_role? :buyer
  end
end
