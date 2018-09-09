class AddNameAndDateToAttendance < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :first_name, :string, null: false
    add_column :attendances, :last_name, :string, null: false
    add_column :attendances, :clock_in_at, :datetime
    add_column :attendances, :clock_out_at, :datetime
  end
end
