# frozen_string_literal: true

class AddDeviseToAdmins < ActiveRecord::Migration[7.2]
  def self.up
    change_table :admins do |t|
      # Add Devise columns
      t.string :encrypted_password, null: false, default: ""
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
    end

    # Only add the index if it doesn't already exist
    unless index_exists?(:admins, :email)
      add_index :admins, :email, unique: true
    end

    # Only add the reset_password_token index if it doesn't already exist
    unless index_exists?(:admins, :reset_password_token)
      add_index :admins, :reset_password_token, unique: true
    end
  end

  def self.down
    # Remove the columns and indexes in the down method
    change_table :admins do |t|
      t.remove :encrypted_password
      t.remove :reset_password_token
      t.remove :reset_password_sent_at
      t.remove :remember_created_at
      t.remove :sign_in_count
      t.remove :current_sign_in_at
      t.remove :last_sign_in_at
      t.remove :current_sign_in_ip
      t.remove :last_sign_in_ip
    end

    remove_index :admins, :email if index_exists?(:admins, :email)
    remove_index :admins, :reset_password_token if index_exists?(:admins, :reset_password_token)
  end
end
