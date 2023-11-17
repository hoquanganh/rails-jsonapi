class CreateWallets < ActiveRecord::Migration[7.1]
  def change
    create_table :wallets do |t|
      t.decimal :balance
      t.string :currency
      t.references :walletable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
