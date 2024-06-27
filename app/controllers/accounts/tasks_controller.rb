class Accounts::TasksController < Accounts::BaseController
  before_action :set_account
  before_action :set_task, only: %i[edit update destroy]

  def index
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

  def edit
    @default_limit_date = @task.limit_date
  end

  def update
    if @task.update(task_params)
      redirect_to root_path, notice: t(".updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy!

    redirect_to root_path, notice: t(".destroyed")
  end
  
  private

  def set_account
    @account = current_user.accounts.find(params[:account_id])
  end

  def set_task
    @task = @account.tasks.find(params[:id])
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

