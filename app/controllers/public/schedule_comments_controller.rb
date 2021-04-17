class Public::ScheduleCommentsController < ApplicationController
  before_action :check_employee_signed

  def create
    @schedule = Schedule.find(params[:schedule_id])
    schedule_comment = current_employee.schedule_comments.new(schedule_comment_params)
    schedule_comment.schedule_id = @schedule.id
    if schedule_comment.save
      @schedule.update(comment_status: true) if @schedule.employee_id != current_employee.id
      flash.now[:success] = 'コメントを投稿しました'
    else
      flash.now[:danger] = 'コメントが正しく保存されませんでした。'
    end
  end

  def destroy
    @schedule = Schedule.find(params[:schedule_id])
    ScheduleComment.find_by(id: params[:id], schedule_id: @schedule.id).destroy
    flash.now[:success] = 'コメントを削除しました'
  end

  private

  def schedule_comment_params
    params.require(:schedule_comment).permit(:comment)
  end
end
