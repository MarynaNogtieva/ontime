class AddUserToAttendaces < ActiveRecord::Migration[5.1]
  def change
    add_reference :attendances, :user, foreign_key: { on_delete: :cascade }, index: true, null: false
  end
end
