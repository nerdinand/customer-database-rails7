class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.datetime :placed_at
      t.datetime :paid_at
      t.datetime :delivered_at

      t.timestamps
    end
  end
end
