class Product < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  # after_commit :create_Product_serialID, on: :create
  after_create :create_Product_serialID

  has_one_attached :cover_picture

  def create_Product_serialID

    s_id =  "Product--" + (Product.count).to_s
    # topic_status = 'Topic Status Updated!'
    update_column(:serial_id, s_id)

  end
end
