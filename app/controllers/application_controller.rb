class ApplicationController < ActionController::Base
  include Public::SessionsHelper

  def after_sign_up_path_for(resource)
    case resource
    when Admin
      admin_companies_path
    when Employee
      schedules_path
    end
  end

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_companies_path
    when Employee
      schedules_path
    end
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
end
