# frozen_string_literal: true

class CreateShippingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_addresses do |t|
      t.string :name
      t.string :phone
      t.string :city
      t.integer :zipcode
      t.string :address
      t.references :customer, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
