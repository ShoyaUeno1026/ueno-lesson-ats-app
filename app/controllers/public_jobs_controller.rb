class PublicJobsController < ApplicationController
  before_action :set_public_jobs
  before_action :set_public_job, only: [:show]

  def index
  end

  def new
    @public_job = @public_jobs.find(params[:public_job_id])
    session[:public_job_id] = @public_job.id
    @account = @public_job.account
    session[:account_id] = @account.id
    @candidate = Candidate.new
  end

  # def create
  #   @account = @public_job.account_id
  #   @department = @public_job.department
  #   @candidate = Candidate.new(candidate_params)
  #   @candidate.account = @account
  #   @candidate.owner = @department.owner

  #   if @candidate.save
  #     redirect_to root_path, notice: t(".created")
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end
  
  def show
  end

  private

  def set_public_jobs
    @public_jobs = Job.all.where(visibility: "public")
  end

  def set_public_job
    @public_job = @public_jobs.find(params[:id])
  end
end
