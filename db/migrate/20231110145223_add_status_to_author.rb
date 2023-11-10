class AddStatusToAuthor < ActiveRecord::Migration[7.1]
  def change
    add_column :authors, :status, :integer, default: 1
  end
end
