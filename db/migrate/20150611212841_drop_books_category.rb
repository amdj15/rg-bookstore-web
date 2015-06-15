class DropBooksCategory < ActiveRecord::Migration
  def up
    drop_table :books_categories
  end

  def down
    create_table :books_categories do |t|
      t.belongs_to :book, index: true, foreign_key: true
      t.belongs_to :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
