class DashboardsController < ApplicationController
  def show
    @account = current_account
    @user = current_user
    @tasks = Task.order("limit_date").all
    @task = Task.new
  end

end
