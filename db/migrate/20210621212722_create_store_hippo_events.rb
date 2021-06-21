class CreateStoreHippoEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :store_hippo_events do |t|
      t.string :event_name
      t.jsonb :data

      t.timestamps
    end
  end
end
