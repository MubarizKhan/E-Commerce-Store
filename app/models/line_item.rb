class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :order, optional: true

  # private
  # self.total_line_item_price = self.quantity * self.
end
