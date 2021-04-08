class Public::GroupsController < ApplicationController
  before_action :sidebar_counts, only: [:show, :edit, :new]
  def new
  end

  def show
  end

  def edit
  end
end
