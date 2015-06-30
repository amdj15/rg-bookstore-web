class AddFieldAdminToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :admin, :boolean, default: false, null: false
  end
end
