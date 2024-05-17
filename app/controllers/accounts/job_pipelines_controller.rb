class Accounts::JobPipelinesController < Accounts::BaseController
  before_action :set_account
  before_action :set_job_pipeline, only: %i[show edit]
  before_action :require_account_admin

  def index
    @job_pipelines = @account.job_pipelines.all
  end

  def show
  end

  def new
    @job_pipeline = JobPipeline.new
  end

  def edit
  end

  def create
    @job_pipeline = JobPipeline.new(job_pipeline_params)
    @job_pipeline.account = @account

    if @job_pipeline.save
      redirect_to account_job_pipeline_url(@account, @job_pipeline), notice: t(".created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:account_id])
  end

  def set_job_pipeline
    @job_pipeline = @account.job_pipelines.find(params[:id])
  end

  def job_pipeline_params
    params.require(:job_pipeline)
      .permit(:name)
  end
end
