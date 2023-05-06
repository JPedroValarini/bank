class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.float :amount
      t.string :transaction_type
      t.references :recipient, foreign_key: { to_table: 'accounts' }
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
