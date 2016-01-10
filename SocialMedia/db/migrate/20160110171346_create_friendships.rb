class CreateFriendships < ActiveRecord::Migration
  
    def change
        create_table :friendships, id: false do |t|
            t.integer :user_id
            t.integer :friend_user_id
        end
    end
end
