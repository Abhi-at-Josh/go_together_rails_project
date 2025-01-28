class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_no
      t.string :email
      t.string :password
      t.string :gender
      t.integer :age

      t.timestamps
    end
  end
end
