class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount
      t.integer :transaction_type
      t.references :to_wallet, null: true, index: true, foreign_key: { to_table: :wallets }
      t.references :from_wallet, null: true, index: true, foreign_key: { to_table: :wallets }

      t.timestamps
    end
  end
end
