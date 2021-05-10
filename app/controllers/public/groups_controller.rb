class Public::GroupsController < ApplicationController
  before_action :check_employee_signed
  before_action :check_current_employee, only: [:edit, :employee_list]
  before_action :sidebar_questions_count
  before_action :sidebar_replies_count

  def new
    @group = Group.new
  end

  def index
    @groups = Group.where(employee_id: current_employee.id)
  end

  def create
    @group = current_employee.groups.new(group_params)
    if @group.save
      flash[:success] = 'グループを作成しました。続いて、従業員の登録をお願いします。'
      redirect_to new_group_group_relationships_path(@group)
    else
      render 'new'
    end
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group), flash: { success: 'グループ名を編集しました。' }
    else
      render 'edit'
    end
  end

  def show
    @group = Group.includes(:employees)
                  .find(params[:id])
    @schedules = Schedule.includes(:employee, :schedule_comments, :schedule_favorites)
                         .where(employee_id: @group.employees.ids)
                         .recent(params[:page])
  end

  def edit; end

  def destroy
    Group.find(params[:id]).destroy
    flash[:success] = 'グループを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def employee_list
    @group = Group.find(params[:group_id])
    @employees = @group.employees
                       .page(params[:page]).per(10)
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  # 自分が作成したグループ以外の編集ページには行けないようにする
  def check_current_employee
    group_id = params[:id] || params[:group_id]
    @group = Group.find(group_id)
    return if @group.employee_id == current_employee.id

    redirect_to schedules_path, flash: { danger: 'アクセスしたページには権限が無いため閲覧できません。' }
  end
end
