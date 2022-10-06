class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items
  belongs_to :coupon, optional: true
end
