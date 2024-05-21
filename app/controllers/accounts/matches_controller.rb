class Accounts::MatchesController < Accounts::BaseController
  before_action :set_account
  before_action :set_match, only: %i[show edit update destroy]

  def index
  end

  def show
  end

  def new
    @match = Match.new

    return unless params[:job_id]

    job = @account.jobs.find(params[:job_id])
    @match.job = job
    flash.now[:notice] = t(".new_from_job", name: job.position_name)
  end

  def edit
  end

  def create
    @match = Match.new(create_params)
    @match.account = @account
    # アカウント内から取得するように再定義
    @match.job = @account.jobs.find(@match.job_id)
    @match.candidate = @account.candidates.find(@match.candidate_id)

    if @match.save
      redirect_to account_job_url(@account, @match.job), notice: t(".created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @match.assign_attributes(update_params)

    # アカウント内から取得するように再定義
    @match.job_pipeline_stage = @account.job_pipeline_stages.find(@match.job_pipeline_stage_id)

    # ステージに応じた日付を記録
    @match.pending_at ||= Time.current if @match.job_pipeline_stage.pending?
    @match.processing_at ||= Time.current if @match.job_pipeline_stage.processing?
    @match.processed_at ||= Time.current if @match.job_pipeline_stage.processed?

    # 不採用の場合
    if update_params[:drop_reasons].present?
      @match.dropped_at ||= Time.current
    else
      @match.dropped_at = nil
      @match.drop_reasons = []
    end

    if @match.save
      redirect_to account_job_url(@account, @match.job), notice: t(".updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @match.destroy!

    redirect_to account_job_url(@account, @match.job), notice: t(".destroyed")
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:account_id])
  end

  def set_match
    @match = @account.matches.find(params[:id])
  end

  def create_params
    params.require(:match)
      .permit(
        :job_id,
        :candidate_id
      )
  end

  def update_params
    params.require(:match)
      .permit(
        :job_pipeline_stage_id,
        drop_reasons: []
      )
  end
end
