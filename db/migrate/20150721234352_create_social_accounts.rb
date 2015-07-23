class CreateSocialAccounts < ActiveRecord::Migration
  def change
    create_table :social_accounts do |t|
      t.belongs_to :customer, index: true, foreign_key: true
      t.string :social
      t.integer :social_id, :limit => 8

      t.timestamps null: false
    end
    add_index :social_accounts, :social
    add_index :social_accounts, :social_id
  end
end
