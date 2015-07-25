class BooksRelationChanging < ActiveRecord::Migration
  def up
    remove_foreign_key :books, column: :author_id
    remove_column :books, :author_id, :integer

    remove_foreign_key :books, column: :category_id
    remove_column :books, :category_id, :integer
  end

  def down
    add_reference :books, :author, index: true, foreign_key: true
    add_reference :books, :category, index: true, foreign_key: true
  end
end
