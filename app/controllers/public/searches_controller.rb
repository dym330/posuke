class Public::SearchesController < ApplicationController
  before_action :check_employee_signed
  before_action :sidebar_questions_count
  before_action :sidebar_replies_count

  def index
    employee_name_or_schedule_title = params[:option]
    how_search = params[:choice]
    if employee_name_or_schedule_title == 'employee_name'
      employees = Employee.search(params[:search], how_search)
                          .where(company_id: current_employee.company_id)
      @schedules = Schedule.includes(:employee, :schedule_comments, :schedule_favorites)
                           .where(employee_id: employees.ids)
                           .order(created_at: :DESC)
    elsif employee_name_or_schedule_title == 'schedule_title'
      company = Company.find(current_employee.company.id)
      @schedules = Schedule.includes(:employee, :schedule_comments, :schedule_favorites)
                           .search(params[:search], how_search)
                           .where(employee_id: company.employees.ids)
                           .order(created_at: :DESC)
    else
      @schedules = []
    end
  end
end
