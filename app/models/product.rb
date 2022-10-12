class Product < ApplicationRecord

  after_create :create_Product_serialID
  # belongs_to :user

  has_many :line_items
  has_many :carts, through: :line_items

  has_many :comments, dependent: :destroy

  resourcify

  belongs_to :users
  belongs_to :sellers, -> { where(roles: {name: :seller}) }, class_name: 'User'
  # belongs_to :buyers, -> { where(roles: {name: :buyer}) }, class_name: 'User'


  has_one_attached :cover_picture

  def create_Product_serialID

    o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
    string = (0...4).map { o[rand(o.length)] }.join
    s_id =  self.name + (Product.count).to_s + string
    update_column(:serial_id, s_id)

  end
end
