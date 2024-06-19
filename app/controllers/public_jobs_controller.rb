class PublicJobsController < ApplicationController
  before_action :set_public_jobs

  def index
  end

  def new
    @public_job = @public_jobs.find(params[:public_job_id])
    @account = @public_job.account
    session[:account_id] = @account.id
    @candidate = Candidate.new
  end
  
  def show
    @public_job = @public_jobs.find(params[:id])
  end

  private

  def set_public_jobs
    @public_jobs = Job.all.where(visibility: "public")
  end
end
