# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :store_order_id
      t.decimal :subtotal
      t.decimal :shipping_total
      t.string :status
      t.string :payment
      t.references :seller, foreign_key: true

      t.timestamps
    end
    add_index :orders, :store_order_id
  end
end
