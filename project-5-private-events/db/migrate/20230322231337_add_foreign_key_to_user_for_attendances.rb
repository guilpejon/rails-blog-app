class AddForeignKeyToUserForAttendances < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :attendances, foreign_key: true
  end
end
