class CreateRetweets < ActiveRecord::Migration[7.1]
  def change
    create_table :retweets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :retweets, [:user_id, :post_id], unique: true
  end
end
