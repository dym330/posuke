class Public::CalendarsController < ApplicationController
  before_action :sidebar_counts
  def index
    @schedules = Schedule.where(employee_id: current_employee.id)
    @schedule = @schedules.first
  end
end
