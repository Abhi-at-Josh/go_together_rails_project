class RemovePasswordDigestFromAdmins < ActiveRecord::Migration[7.2]
  def change
    remove_column :admins, :password_digest, :string
  end
end
