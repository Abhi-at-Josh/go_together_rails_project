
class RenamePasswordToPasswordDigestInAdmins < ActiveRecord::Migration[7.2]
  def change
    rename_column :admins, :password, :password_digest
  end
end
