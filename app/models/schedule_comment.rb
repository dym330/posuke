class ScheduleComment < ApplicationRecord
  validates :comment, presence: true, length: { in: 1..1000 }
  belongs_to :employee
  belongs_to :schedule
end
