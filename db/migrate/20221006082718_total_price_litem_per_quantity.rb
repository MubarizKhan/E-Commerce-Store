class TotalPriceLitemPerQuantity < ActiveRecord::Migration[6.1]
  def change
    add_column :line_items, :total_line_item_price, :decimal

  end
end
