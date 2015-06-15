class AddPriceToBook < ActiveRecord::Migration
  def change
    add_column :books, :price, :float
  end
end
