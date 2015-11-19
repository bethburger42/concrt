class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.column :user_id, :integer
      t.column :friend_id, :integer
    end
  end
end