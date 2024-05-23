class Accounts::JobPipelines::JobPipelineStagesController < Accounts::BaseController
  before_action :set_account
  before_action :set_job_pipeline
  before_action :set_job_pipeline_stage, only: %i[show edit update destroy]
  before_action :require_account_admin

  def index
  end
  
  def show
  end

  def new
    @job_pipeline_stage = JobPipelineStage.new
  end

  def editing
  end

  def create
    @job_pipeline_stage = JobPipelineStage.new(job_pipeline_stage_params)
    @job_pipeline_stage.account = @account
    @job_pipeline_stage.job_pipeline = @job_pipeline

    if @job_pipeline_stage.save
      redirect_to account_job_pipeline_url(@account, @job_pipeline), notice: t(".created", name: @job_pipeline_stage.name)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @job_pipeline_stage.update(job_pipeline_stage_params)
      redirect_to account_job_pipeline_url(@account, @job_pipeline), notice: t(".updated", name: @job_pipeline_stage.name)
    else
      rendere :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @job_pipeline_stage.destroy!

    redirect_to account_job_pipeline_url(@account, @job_pipeline), notice: t(".destroyed", name: @job_pipeline_stage.name)
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:account_id])
  end

  def set_job_pipeline
    @job_pipeline = @account.job_pipelines.find(params[:job_pipeline_id])
  end

  def set_job_pipeline_stage
    @job_pipeline_stage = @job_pipeline.stages.find(params[:id])
  end

  def job_pipeline_stage_params
    params.require(:job_pipeline_stage)
      .permit(:name, :kind, :display_order)
  end
end
