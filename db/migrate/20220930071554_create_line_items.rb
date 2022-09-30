class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.integer :quantity
      t.references :cart, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      add_column :products, :item_quantity, :integer
      t.timestamps
    end
  end
end
