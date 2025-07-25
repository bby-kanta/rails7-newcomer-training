class AddPrivateToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :private, :boolean, default: false, null: false
  end
end
