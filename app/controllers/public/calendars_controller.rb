class Public::CalendarsController < ApplicationController
  before_action :check_employee_signed
  before_action :sidebar_counts
  def index
    @schedules = Schedule.where(employee_id: params[:employee_id])
    @schedule_employee = Employee.find(params[:employee_id])
  end
end
