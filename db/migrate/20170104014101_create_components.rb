class CreateComponents < ActiveRecord::Migration[5.0]
  def change
    create_table :components do |t|
      t.string :name
      t.integer :quantity
      t.float :price

      t.timestamps
    end
  end
end
