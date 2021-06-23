# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.string :name
      t.decimal :price
      t.integer :quantity
      t.references :product, foreign_key: true
      t.jsonb :options
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
