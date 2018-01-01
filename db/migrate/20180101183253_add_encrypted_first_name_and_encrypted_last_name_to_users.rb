class AddEncryptedFirstNameAndEncryptedLastNameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :encrypted_first_name, :string
    add_column :users, :encrypted_last_name, :string
  end
end
