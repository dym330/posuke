class Public::GroupsController < ApplicationController
  before_action :sidebar_counts
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
      flash[:success] = 'グループ名を編集しました'
      redirect_to group_path(@group)
    else
      render 'edit'
    end
  end

  def show
    @group = Group.find(params[:id])
    @schedules = Schedule.where(employee_id: @group.employees.ids).order(created_at: :DESC)
  end

  def edit
    @group = Group.find(params[:id])
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
