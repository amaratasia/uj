# frozen_string_literal: true

class CreateProductAttributes < ActiveRecord::Migration[5.2]
  def change
    create_table :product_attributes do |t|
      t.string :name
      t.string :value
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
