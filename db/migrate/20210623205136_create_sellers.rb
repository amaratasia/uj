# frozen_string_literal: true

class CreateSellers < ActiveRecord::Migration[5.2]
  def change
    create_table :sellers do |t|
      t.string :pan
      t.string :city
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
