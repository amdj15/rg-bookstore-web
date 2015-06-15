class AddCompletedDateToOrderAndRemoveCompletedFromOrder < ActiveRecord::Migration
  def change
    add_column :orders, :completed_date, :date
    remove_column :orders, :completed
  end
end
