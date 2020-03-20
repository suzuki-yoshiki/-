class AddUserIdToMemos < ActiveRecord::Migration[5.1]
  def change
    add_column :memos, :user_id, :integer
  end
end
