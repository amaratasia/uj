# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :store_product_id
      t.integer :store_pid
      t.string :sku
      t.string :name
      t.string :description
      t.decimal :price
      t.references :school, foreign_key: true

      t.timestamps
    end
    add_index :products, :store_pid
    add_index :products, :sku
  end
end
