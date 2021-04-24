class ApplicationController < ActionController::Base
  include Public::SessionsHelper

  # サイドバーに表示するために、質問一覧数を返す
  def sidebar_questions_count
    @employee_ids_in_current_company = Company.find(current_employee.company_id).employees.ids
    @schedule_questions_count = Schedule.where(employee_id: @employee_ids_in_current_company)
                                        .where(schedule_status: 1)
                                        .count
  end

  # サイドバーに表示するために、返信一覧数を返す
  def sidebar_replies_count
    @schedule_replies_count = Schedule.where(employee_id: current_employee.id)
                                      .where(comment_status: true)
                                      .count
  end

  def after_sign_in_path_for(resource)
    admin_companies_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
