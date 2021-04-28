class Public::SessionsController < ApplicationController
  def create
    @employee = Employee.find_by(email: params[:session][:email])
    if @employee && @employee.authenticate(params[:session][:password])
      check_enrollment_and_usage_status and return
      log_in(@employee)
      redirect_to schedules_path
    else
      flash[:danger] = 'Eメールまたはパスワードが違います。'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url, flash: { success: 'ログアウトしました。' }
  end

  def new; end

  def guest_create
    employee = Employee.find_by(email: 'guest@guest.com')
    log_in(employee)
    redirect_to schedules_path, flash: { success: 'ゲストユーザーとしてログインしました。' }
  end

  private

  # 従業員の在籍状況、企業の継続状況をチェック
  def check_enrollment_and_usage_status
    return if @employee.enrollment_status == true && @employee.company.usage_status == true

    flash[:danger] = 'ログインが認められませんでした。'
    render 'new'
  end
end
