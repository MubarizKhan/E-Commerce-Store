# frozen_string_literal: true

class Product < ApplicationRecord
  resourcify

  after_create :create_product_serial_id
  belongs_to :user

  has_many :line_items
  has_many :carts, through: :line_items

  has_many :comments, dependent: :destroy

  # belongs_to :users
  # belongs_to :sellers, -> { where(roles: {name: :seller}) }, class_name: 'User'
  # belongs_to :seller, class_name: 'User'
  # belongs_to :buyers, -> { where(roles: {name: :buyer}) }, class_name: 'User'

  has_one_attached :cover_picture

  validates :name, :item_price, :item_quantity, :cover_picture, presence: true
  def create_product_serial_id
    s_id = name + Product.count.to_s + rand(222_777).to_s
    update_column(:serial_id, s_id)
  end
end
