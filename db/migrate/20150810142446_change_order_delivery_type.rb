class ChangeOrderDeliveryType < ActiveRecord::Migration
  def up
    change_table :orders do |t|
      t.change :delivery_type, :string
    end

    add_index :orders, :delivery_type
  end

  def down
    change_table :orders do |t|
      t.change :delivery_type, :integer
    end

    remove_index :orders, :delivery_type
  end
end
