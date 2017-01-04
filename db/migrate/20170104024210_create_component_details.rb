class CreateComponentDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :component_details do |t|
      t.references :component, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
