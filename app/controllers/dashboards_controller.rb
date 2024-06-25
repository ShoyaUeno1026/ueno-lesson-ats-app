class DashboardsController < ApplicationController
  def show
    @accounts = current_user.accounts.order(:created_at)
    @account = current_account
  end
end
