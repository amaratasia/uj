# frozen_string_literal: true

class CreateTaxes < ActiveRecord::Migration[5.2]
  def change
    create_table :taxes do |t|
      t.string :name
      t.references :order, foreign_key: true
      t.decimal :rate
      t.decimal :total

      t.timestamps
    end
  end
end
