class AddCookieToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :cookie, :string
  end
end
