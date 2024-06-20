class Accounts::CandidatesController < Accounts::BaseController
  before_action :set_account, except: [:create_from_public_job]
  before_action :set_candidate, only: %i[show edit update destroy]
  before_action :require_candidate_owner_or_admin, only: %i[edit update destroy]
  skip_before_action :authenticate_user!, only: [:create_from_public_job] # ログイン不要なアクション

  def index
    @candidates = @account.candidates.all
  end

  def show
  end

  def new
    @candidate = Candidate.new
  end

  def edit
  end

  def create
    @candidate = Candidate.new(candidate_params)
    @candidate.account = @account
    @candidate.owner = current_user

    if @candidate.save
      redirect_to account_candidate_url(@account, @candidate), notice: t(".created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def create_from_public_job
    @account = Account.find_by(id: session[:account_id])
    
    if @account.present?
      @candidate = @account.candidates.build(candidate_params)
      @candidate.owner = @account.owner
      @candidate.from_public_job = true # 仮想的な属性として設定する

      if @candidate.save
        redirect_to public_jobs_url, notice: t(".entered")
        session.delete(:account_id)
      else
        render 'public_jobs/new'
      end
    else
      # アカウントが見つからない場合のエラーハンドリング
      render 'public_jobs/new'
    end
  end

  def update
    if @candidate.update(candidate_params)
      redirect_to account_candidate_url(@account, @candidate), notice: t(".updated", name: @candidate.name)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @candidate.destroy!

    redirect_to account_candidates_url(@account), notice: t(".destroyed", name: @candidate.name)
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:account_id])
  end

  def set_candidate
    @candidate = @account.candidates.find(params[:id])
  end

  def candidate_params
    params.require(:candidate)
      .permit(
        :image,
        :name,
        :email,
        :phone_number,
        :gender,
        :birth_date,
        :location,
        :source_type,
        :is_employee,
        :custom_fields,
        :job_id
      )
  end

  def require_candidate_owner_or_admin
    redirect_to [@account, @candidate], alert: t("not_allowed") unless @candidate.owner?(current_user) || current_account_admin?
  end
end
