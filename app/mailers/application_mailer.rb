# frozen_string_literal: true

# Your Ruby code goes here

class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"
end
