class Accounts::CandidatesController < Accounts::BaseController
  before_action :set_account
  before_action :set_candidate, only: %i[show edit update destroy]
  before_action :require_candidate_owner_or_admin, only: %i[edit update destroy]

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
        :custom_fields
      )
  end

  def require_candidate_owner_or_admin
    redirect_to [@account, @candidate], alert: t("not_allowed") unless @candidate.owner?(current_user) || current_account_admin?
  end
end
