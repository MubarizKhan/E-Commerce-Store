class PriceAdditionToProducts < ActiveRecord::Migration[6.1]
  def change
    # :products, :users,
    add_column :products, :item_price, :integer
    # add_column :shows, :url_rss, :string

  end
end
