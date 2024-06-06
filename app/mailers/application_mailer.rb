class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout "mailer"

  # Include any view helpers from your main app to use in mailers here
  helper ApplicationHelper
end
