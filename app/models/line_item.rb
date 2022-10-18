# frozen_string_literal: true
# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :order, optional: true
  belongs_to :product
  # valida

  def set_price
    update(total_line_item_price: product.item_price * quantity)
  end
end

# class LineItem < ApplicationRecord
#   belongs_to :cart, optional: true
#   belongs_to :product
#   belongs_to :order, optional: true

#   def set_price(product)
#     self.update(total_line_item_price: product.item_price * self.quantity)
#   end

#   def set_price(product = Product.first)
#     self.update(total_line_item_price: product.item_price * self.quantity)
#   end

#   def set_price
#     self.update(total_line_item_price: product.item_price * self.quantity)
#     self.update(total_line_item_price: Product.find_by_id(product_id).item_price * quantity)
#     self.update(total_line_item_price: Product.find_by_id(product_id).item_price * quantity)
#     self.update(total_line_item_price: product.item_price * quantity)
#     self.update(total_line_item_price: self.product.item_price * self.quantity)

#     Product.find_by_id(product_id)
#     Product.find_by!(id: product_id)
#     Product.find(product_id)
#     Product.find(product_id)

#   end
# end
