class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :address
      t.string :zip_code
      t.string :city
      t.string :phone_number

      t.timestamps
    end
  end
end
