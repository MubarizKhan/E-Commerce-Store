# frozen_string_literal: true

class Order < ApplicationRecord
  include ActiveModel::Dirty

  enum status: { inititated: 0, in_progress: 1, completed: 2 }

  belongs_to :user
  has_many :line_items
  belongs_to :coupon, optional: true
end
