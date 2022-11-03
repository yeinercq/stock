class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone_number, null: false
      t.string :id_number, null: false
      t.string :address, null: false

      t.timestamps
    end
    add_index :customers, :email
    add_index :customers, :id_number
  end
end
