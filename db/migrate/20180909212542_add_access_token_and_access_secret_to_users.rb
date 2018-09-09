class AddAccessTokenAndAccessSecretToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :access_token, :string
    add_column :users, :access_secret, :string
  end
end
