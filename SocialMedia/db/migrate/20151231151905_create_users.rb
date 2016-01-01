class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :password
      t.integer :sex
      t.date :birth_date
      t.string :interests
      t.string :description
      t.integer :gravatar
      t.string :following
      t.string :followed_by

      t.timestamps null: false
    end
  end
end
