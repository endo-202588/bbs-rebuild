class AddLoginLockToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :failed_logins_count, :integer, default: 0, null: false
    add_column :users, :lock_expires_at, :datetime
    add_column :users, :unlock_token, :string

    add_index :users, :unlock_token, unique: true
  end
end
