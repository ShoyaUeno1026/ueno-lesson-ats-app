class Entry::JobsController < ApplicationController
  before_action :set_jobs

  def index
  end

  def new
    @job = @jobs.find(params[:job_id])
    @account = @job.account
    @candidate = Candidate.new
  end

  def show
    @job = @jobs.find(params[:id])
  end

  private
  
  def set_jobs
    @jobs = Job.where(visibility: "public").order(created_at: :desc)
  end
end