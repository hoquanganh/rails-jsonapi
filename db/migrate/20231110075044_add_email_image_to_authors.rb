class AddEmailImageToAuthors < ActiveRecord::Migration[7.1]
  def change
    add_column :authors, :email, :string
    add_column :authors, :image, :string
  end
end
