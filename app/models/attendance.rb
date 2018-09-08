class Attendance < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  validates :first_name, :last_name, presence: true
end
