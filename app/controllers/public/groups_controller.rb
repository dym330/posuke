class Public::GroupsController < ApplicationController
  before_action :sidebar_counts
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = 'グループを作成しました。続いて、従業員の登録をお願いします。'
      redirect_to new_group_grouprelationship_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
