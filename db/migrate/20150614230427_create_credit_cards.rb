class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string :number
      t.integer :CVV
      t.string :month
      t.integer :year
      t.string :firstname
      t.string :lastname

      t.timestamps null: false
    end

    add_reference :orders, :credit_card, index: true, foreign_key: true
  end
end
