module Public::SessionsHelper
  # ログイン処理
  def log_in(employee)
    session[:employee_id] = employee.id
  end

  # ログインしている従業員を取得する
  def current_employee
    return unless session[:employee_id]

    @current_employee ||= Employee.find_by(id: session[:employee_id])
  end

  # 従業員がログインしているかどうかを真偽値で返す
  def employee_signed_in?
    !current_employee.nil?
  end

  # ログインしていないユーザーをTOPページに返す
  def check_employee_signed
    return if employee_signed_in?

    redirect_to login_path, flash: { danger: 'ログインしてください' }
  end

  # ログアウト処理
  def log_out
    session.delete(:employee_id)
    @current_employee = nil
  end
end
