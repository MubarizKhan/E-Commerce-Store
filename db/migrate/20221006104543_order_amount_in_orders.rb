class OrderAmountInOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :order_amount, :decimal
  end
end
