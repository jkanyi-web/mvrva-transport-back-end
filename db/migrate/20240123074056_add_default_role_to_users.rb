class AddDefaultRoleToUsers < ActiveRecord::Migration[7.1]
  def up
    change_column :users, :role, :string, default: 'user'
  end

  def down
    change_column :users, :role, :string, default: nil
  end
end
