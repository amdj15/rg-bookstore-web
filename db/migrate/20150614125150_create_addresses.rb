class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :zip
      t.string :city
      t.string :phone

      t.timestamps null: false
    end
  end
end
