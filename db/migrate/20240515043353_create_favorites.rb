class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true, :null => false
      t.references :post, foreign_key: true, :null => false
      t.timestamps
    end
    add_index :favorites, [:user_id, :post_id], unique: true
  end
end
