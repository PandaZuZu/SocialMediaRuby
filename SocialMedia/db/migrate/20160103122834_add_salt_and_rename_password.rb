class AddSaltAndRenamePassword < ActiveRecord::Migration
  def self.up
      rename_column :Users, :password, :encrypted_password
      add_column :Users, :salt, :string
  end
end
