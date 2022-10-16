# frozen_string_literal: true

class Product < ApplicationRecord
  resourcify

  after_create :create_Product_serialID
  belongs_to :user

  has_many :line_items
  has_many :carts, through: :line_items

  has_many :comments, dependent: :destroy

  # belongs_to :users
  # belongs_to :sellers, -> { where(roles: {name: :seller}) }, class_name: 'User'
  # belongs_to :seller, class_name: 'User'
  # belongs_to :buyers, -> { where(roles: {name: :buyer}) }, class_name: 'User'

  has_one_attached :cover_picture

  def create_Product_serialID

    randomnum1 = rand(222777)
    randomnum2 = rand(222777)

    s_id = name + Product.count.to_s + randomnum2.to_s + randomnum1.to_s
    update_column(:serial_id, s_id)
  end
end
