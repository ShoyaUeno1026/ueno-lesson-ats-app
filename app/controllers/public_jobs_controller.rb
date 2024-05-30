class PublicJobsController < ApplicationController
  def index
    @account = Account.all
    @public_jobs = Job.all.where(visibility: "public")
  end

end
