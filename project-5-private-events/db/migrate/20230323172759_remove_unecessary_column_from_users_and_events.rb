class RemoveUnecessaryColumnFromUsersAndEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :attendances_id
    remove_column :users, :attendances_id
  end
end
