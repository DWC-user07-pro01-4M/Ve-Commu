class AddNicknameAndIsDeletedToEndUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :end_users, :nickname, :string, null: false
    add_column :end_users, :is_deleted, :boolean, default: false
  end
end