class Accounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.float :balance
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
