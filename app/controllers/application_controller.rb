class ApplicationController < ActionController::Base
  include Public::SessionsHelper

  def sidebar_counts
    @schedule_questions_count = Schedule.where(employee_id: Company.find(current_employee.company.id).employees.ids)
                                              .where(schedule_status: 1).count
    @schedule_replies_count = @schedules = Schedule.where(employee_id: current_employee.id).where(comment_status: true).count
  end

  def after_sign_in_path_for(resource)
    admin_companies_path
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
end
