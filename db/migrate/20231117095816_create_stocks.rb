class CreateStocks < ActiveRecord::Migration[7.1]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :company_name
      t.decimal :price

      t.timestamps
    end
  end
end
