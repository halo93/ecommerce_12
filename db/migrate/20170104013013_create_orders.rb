class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :order_code
      t.integer :status
      t.float :total_pay
      t.string :shipping_address
      t.references :user, foreign_key: true
      t.references :coupon, foreign_key: true

      t.timestamps
    end
  end
end
