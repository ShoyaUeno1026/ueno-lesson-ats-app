class Entry::CandidatesController < ApplicationController
  def create
    @account = Account.find(params[:account_id])
    @job = Job.find(params[:job_id])
    
    @candidate = Candidate.new(candidate_params)
    @candidate.account = @account
    @candidate.owner = @account.owner
    @candidate.from_entry_job = true # 仮想的な属性として設定する

    if @candidate.save
      redirect_to jobs_url, notice: t(".entered")
    else
      render "entry/jobs/new", status: :unprocessable_entity
    end
  end

  private

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
end
