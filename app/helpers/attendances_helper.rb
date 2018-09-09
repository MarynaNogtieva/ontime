# frozen_string_literal: true

module AttendancesHelper
  def full_name(attendance)
    "#{attendance.first_name} #{attendance.last_name}"
  end

  def clock_out_time(attendance)
    return attendance.clock_out_at&.strftime('%Y-%m-%dT%H:%M') if attendance.clock_out_at.present?
    return DateTime.now.strftime('%Y-%m-%dT%H:%M') if attendance.allow_clock_out?
  end
end
