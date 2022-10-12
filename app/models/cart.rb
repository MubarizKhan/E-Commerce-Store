class Cart < ApplicationRecord
  belongs_to :user
  has_many :line_items
  has_many :products, through: :line_items


  # has_many :users, through: :roles, class_name: 'User', source: :users
end
