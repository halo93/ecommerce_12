class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.string :discount_code
      t.string :description
      t.integer :redemption
      t.integer :coupon_type

      t.timestamps
    end
  end
end
