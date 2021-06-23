# frozen_string_literal: true

class CreateVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :variants do |t|
      t.string :sku
      t.decimal :price
      t.string :name
      t.string :value
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
