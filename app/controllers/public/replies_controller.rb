class Public::RepliesController < ApplicationController
  before_action :check_employee_signed
  before_action :sidebar_questions_count
  before_action :sidebar_replies_count
  def index
    @schedules = Schedule.where(employee_id: current_employee.id).where(comment_status: true).order(created_at: :DESC)
  end
end
