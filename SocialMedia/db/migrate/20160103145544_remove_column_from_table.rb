class RemoveColumnFromTable < ActiveRecord::Migration
  def self.up
      remove_column :Users, :interests
  end
end
