# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :order, optional: true
  belongs_to :product
# valida

  def set_price
    self.update(total_line_item_price: product.item_price * quantity)
  end
end
