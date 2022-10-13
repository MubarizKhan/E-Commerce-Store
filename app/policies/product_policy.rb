# frozen_string_literal: true

class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if @user.has_role? :seller
        scope.all
      else
        scope.where(content: '')
      end
    end
  end

  def index?
    true
  end

  def new?
    @user.has_role? :seller
  end

  def create
    current_user.has_role? :seller
  end

  # def
end

# end
