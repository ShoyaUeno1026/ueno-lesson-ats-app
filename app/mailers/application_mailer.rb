class ApplicationMailer < ActionMailer::Base
  default from: Rails.configuration.shiraha.support_email
  layout "mailer"

  # Include any view helpers from your main app to use in mailers here
  helper ApplicationHelper
end
