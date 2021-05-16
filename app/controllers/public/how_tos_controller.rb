class Public::HowTosController < ApplicationController
  before_action :check_employee_signed
  before_action :sidebar_questions_count
  before_action :sidebar_replies_count
  def index; end
end
