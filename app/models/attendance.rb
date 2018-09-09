# frozen_string_literal: true

class Attendance < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  validates :first_name, :last_name, presence: true

  def allow_clock_in?
    clock_in_at.blank? && clock_out_at.blank? || clock_in_at.present?
  end

  def allow_clock_out?
    clock_in_at.present? && clock_out_at.blank? && record_exists? || clock_out_at.present?
  end

  def record_exists?
    Attendance.exists?(user_id: user_id, clock_in_at: clock_in_at)
  end
end
