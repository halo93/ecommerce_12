class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :product_code
      t.string :name
      t.string :image
      t.float :price
      t.integer :in_stock
      t.text :description
      t.float :avarage_rating
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
