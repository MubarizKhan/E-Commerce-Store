class FkUpdationUnitPriceAddition < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :comments, :products
    add_foreign_key :comments, :products, on_delete: :cascade

    remove_foreign_key :line_items, :products
    add_foreign_key :line_items, :products, on_delete: :cascade

    remove_foreign_key :products, :users
    add_foreign_key :products, :users, on_delete: :cascade

    # add_column :products, item_price, integer



  end
end
