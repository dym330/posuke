class Public::SessionsController < ApplicationController
  def new
  end

  def create
    employee = Employee.find_by(email: params[:session][:email])
    if employee && employee.authenticate(params[:session][:password])
      # 従業員の在籍状況、企業の継続状況をチェック
      unless employee.enrollment_status == true &&
             employee.company.usage_status == true
        flash.now[:danger] = 'ログインが認められませんでした。'
        return render 'new'
      end
      log_in(employee)
      redirect_to schedules_path
    else
      flash.now[:danger] = 'Eメールまたはパスワードが違います。'
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

  def guest_create
    employee = Employee.find_by(email: "guest@guest.com")
    log_in(employee)
    flash[:success] = 'ゲストユーザーとしてログインしました。'
    redirect_to schedules_path
  end

end
