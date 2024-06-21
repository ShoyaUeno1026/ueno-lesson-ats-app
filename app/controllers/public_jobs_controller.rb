class PublicJobsController < ApplicationController
  before_action :set_public_jobs

  def index
  end

  def new
    @public_job = @public_jobs.find(params[:public_job_id])
    @account = @public_job.account
    @candidate = Candidate.new
  end
  
  def show
    @public_job = @public_jobs.find(params[:id])
  end

  private

  def set_public_jobs
    @public_jobs = Job.where(visibility: "public").order(created_at: :desc)
  end
end
