class OrderStatusChange < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :order_status

  end
end
