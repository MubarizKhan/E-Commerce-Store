class Change < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :coupon_id
    add_column :orders, :coupon_name, :string
  end
end
