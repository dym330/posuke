class Public::RepliesController < ApplicationController
  before_action :sidebar_counts
  def index
    @schedules = Schedule.where(employee_id: current_employee.id).where(comment_status: true).order(created_at: :DESC)
  end
end
