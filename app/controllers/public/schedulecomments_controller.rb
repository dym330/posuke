class Public::SchedulecommentsController < ApplicationController

  def create
    schedule = Schedule.find(params[:schedule_id])
    schedule_comment = current_employee.schedule_comments.new(schedule_comment_params)
    schedule_comment.schedule_id = schedule.id
    if schedule_comment.save
      flash[:success] = 'コメントを投稿しました'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'コメントが正しく保存されませんでした。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
     p params[:schedule_id]
    ScheduleComment.find_by(id: params[:id], schedule_id: params[:schedule_id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def schedule_comment_params
    params.require(:schedule_comment).permit(:comment)
  end
end
