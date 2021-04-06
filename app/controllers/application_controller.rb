class ApplicationController < ActionController::Base

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

  # def after_sign_out_path_for(resource_or_scope)
  #   # if resource_or_scope == :customer
  #     root_path
  #   # elsif resource_or_scope == :organizer
  #     # root_path
  #   # end
  # end
end
