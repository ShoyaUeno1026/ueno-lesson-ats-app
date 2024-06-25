class Accounts::TasksController < Accounts::BaseController
  before_action :set_account

  def index
  end

  def new
  end

  def create
    @task = Task.new(task_params)
    @task.account_id = @account.id
    @task.user_id = current_user.id

    if @task.save
      redirect_to root_path, notice: t(".created")
    else
      render "dashboards/show", status: :unprocessable_entity
    end
  end
  
  def show
  end

  def update
  end

  def destroy
  end
  
  private

  def set_account
    @account = current_user.accounts.find(params[:account_id])
  end
  
  def task_params
    params.require(:task)
      .permit(
        :account_id,
        :user_id,
        :state,
        :content,
        :limit_date
      )
  end
end

