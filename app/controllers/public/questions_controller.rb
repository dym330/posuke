class Public::QuestionsController < ApplicationController
  before_action :sidebar_counts
  def index
    @company = Company.find(current_employee.company.id)
    @schedules = Schedule.where(employee_id: @company.employees.ids).where(schedule_status: 1).order(created_at: :DESC)
  end
end
