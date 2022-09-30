class Cart < ApplicationRecord
  belongs_to :user
  has_many :products, through: :line_items
end
