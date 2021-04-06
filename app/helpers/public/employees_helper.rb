module Public::EmployeesHelper
  # ログインしている従業員が、admin権限のある従業員かどうかの判別
  def admin_employee_login?
    current_employee.admin
  end
end
