# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :product
  belongs_to :order, optional: true

  # def self.set_price
  #   self.total_line_item_price = Product.find(self.product_id).item_price * self.quantity
  # end
end
