class ChangeColumnStoreOrderIdFromOrdersToString < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :store_order_id, :string

  end
end
