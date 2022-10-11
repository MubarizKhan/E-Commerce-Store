class Order < ApplicationRecord
  # include ActiveModel::Validations
  include ActiveModel::Dirty
  enum status: { newly_created: 0, adding_items: 1, completed: 2 }


  belongs_to :user
  has_many :line_items
  belongs_to :coupon, optional: true



end

