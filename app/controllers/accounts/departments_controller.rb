class Accounts::DepartmentsController < Accounts::BaseController
  before_action :set_account
  before_action :set_department, only: %i[show edit]
  before_action :require_account_admin, only: %i[new create]

  def index
  end

  def show
  end

  def new
    @department = Department.new
  end

  def edit
  end

  def create
    @department = Department.new(department_params)
    @department.account = @account
    @department.owner = current_user

    if @department.save
      redirect_to account_department_url(@account, @department), notice: t(".created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:account_id])
  end

  def set_department
    @department = @account.departments.find(params[:id])
  end

  def department_params
    params.require(:department)
      .permit(:name, :description, :industry, :location, :website)
  end

  def require_department_owner_or_admin
    redirect_to [@account, @department], alert: t("not_allowed") unless @department.owner?(current_user) || current_account_admin?
  end
end
