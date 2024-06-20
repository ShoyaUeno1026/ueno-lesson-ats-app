class Accounts::JobsController < Accounts::BaseController
  before_action :set_account
  before_action :set_job, only: %i[show edit update destroy]
  before_action :require_job_owner_or_admin, only: %i[edit update destroy]

  def index
    @jobs = @account.jobs.all
  end

  def show
    @job_pipeline_stages = @job.job_pipeline.stages.list
    @match_histories = @account.match_histories.where(job_id: @job.id).order(created_at: :desc)
  end

  def new
    @job = Job.new
    @job.job_pipeline = @account.job_pipelines.default.first

    return unless params[:department_id]

    department = @account.departments.find(params[:department_id])
    @job.department = department
    flash.now[:notice] = t(".new_from_department", name: department.name)
  end

  def edit
  end

  def create
    @job = Job.new(job_params)
    @job.account = @account
    @job.owner = current_user

    if @job.save
      redirect_to account_job_url(@account, @job), notice: t(".created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @job.update(job_params)
      redirect_to account_job_url(@account, @job), notice: t(".updated", name: @job.position_name)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    candidates_to_update = Candidate.where(job_id: @job.id)
    candidates_to_update.update_all(job_id: nil)
    @job.destroy!

    redirect_to account_jobs_url(@account), notice: t(".destroyed", name: @job.position_name)
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:account_id])
  end

  def set_job
    @job = @account.jobs.find(params[:id])
  end

  def job_params
    params.require(:job)
      .permit(
        :department_id,
        :job_pipeline_id,
        :position_name,
        :contract,
        :currency,
        :description,
        :frequency,
        :headcount,
        :is_remote,
        :location,
        :salary_min,
        :salary_max,
        :visibility
      )
  end

  def require_job_owner_or_admin
    redirect_to [@account, @job], alert: t("not_allowed") unless @job.owner?(current_user) || current_account_admin?
  end
end
