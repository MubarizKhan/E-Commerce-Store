# frozen_string_literal: true

class Order < ApplicationRecord
  include ActiveModel::Dirty

  enum status: { inititated: 0, in_progress: 1, completed: 2 }

  scope :done, -> { where('status > 1') }

  scope :current, -> { where('status < 2') }

  belongs_to :user
  has_many :line_items
  belongs_to :coupon, optional: true

  # Order.completed
  # Order.in_progress
  # Order.inititated

  def self.completed_orders
    where('status > 1')
    where(status: :completed)
  end

  # def calculate_discount(coupon)
  #   # coupon.discount
  #   # if coupon
  #   discounted_price = order_amount - (order_amount * coupon.discount)
  #   self.update(order_amount: discounted_price, coupon_name: coupon.coupon_name)

  # end
end

# add delegate method for LineItem.first.product_name -> delegate
