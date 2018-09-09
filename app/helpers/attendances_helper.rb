# frozen_string_literal: true

module AttendancesHelper
  def full_name(attendance)
    "#{attendance.first_name} #{attendance.last_name}"
  end
end
