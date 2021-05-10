class Public::RepliesController < ApplicationController
  before_action :check_employee_signed
  before_action :sidebar_questions_count
  before_action :sidebar_replies_count
  def index
    @schedules = Schedule.includes(:employee, :schedule_comments, :schedule_favorites)
                         .where(employee_id: current_employee.id)
                         .where(comment_status: true)
                         .recent(params[:page])
  end
end
