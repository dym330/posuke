class Public::QuestionsController < ApplicationController
  before_action :check_employee_signed
  before_action :sidebar_replies_count
  def index
    @employee_ids_in_current_company = Company.find(current_employee.company.id).employees.ids
    @schedules = Schedule.includes(:employee, :schedule_comments, :schedule_favorites)
                         .where(employee_id: @employee_ids_in_current_company)
                         .where(schedule_status: 1)
                         .recent(params[:page])
    @schedule_questions_count = Schedule.where(employee_id: @employee_ids_in_current_company)
                                        .where(schedule_status: 1)
                                        .count
  end
end
