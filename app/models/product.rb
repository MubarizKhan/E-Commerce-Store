class Product < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy


  has_many :line_items
  has_many :carts, through: :line_items
  after_create :create_Product_serialID

  has_one_attached :cover_picture

  def create_Product_serialID
    o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
    string = (0...4).map { o[rand(o.length)] }.join

    s_id =  self.name + (Product.count).to_s + string
    update_column(:serial_id, s_id)

  end
end
