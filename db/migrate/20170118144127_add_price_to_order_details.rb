class AddPriceToOrderDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :order_details, :price, :float
  end
end
