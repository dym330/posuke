class ScheduleComment < ApplicationRecord
  belongs_to :employee
  belongs_to :schedule
end
