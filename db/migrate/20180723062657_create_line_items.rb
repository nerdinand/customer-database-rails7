class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :amount

      t.timestamps
    end
  end
end
