class ChangeColumnTypeProducts < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :store_pid, :string
  end
end
