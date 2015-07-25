class AddShortDescToBook < ActiveRecord::Migration
  def change
    add_column :books, :short_descr, :string, after: :description
  end
end
