class Public::CalendarsController < ApplicationController
  before_action :check_employee_signed
  before_action :sidebar_questions_count
  before_action :sidebar_replies_count
  def index
    @schedules = Schedule.where(employee_id: params[:employee_id])
    @schedule_employee = Employee.find(params[:employee_id])
  end
end
