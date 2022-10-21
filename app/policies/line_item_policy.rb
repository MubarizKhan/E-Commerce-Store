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
    @user.has_role? :buyer

  end
end
