class Public::SearchesController < ApplicationController
  before_action :check_employee_signed
  before_action :sidebar_questions_count
  before_action :sidebar_replies_count

  def index
    employee_name_or_schedule_title = params[:option]
    how_search = params[:choice]
    case employee_name_or_schedule_title
    when 'employee_name'
      employees = Employee.search(params[:search], how_search, current_employee)
      @schedules = Schedule.employees_search(employees.ids, params[:page])
    when 'schedule_title'
      company = Company.find(current_employee.company_id)
      @schedules = Schedule.search(params[:search], how_search, company.employees.ids, params[:page])
    else
      @schedules = []
    end
  end
end
