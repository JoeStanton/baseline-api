class IncidentMailer < ActionMailer::Base
  default from: "incidents@monitoring.joestanton.co.uk"

  def detected
    mail(to: "joe.stanton@red-badger.com", subject: "Incident Detected")
  end

  def resolved
    mail(to: "joe.stanton@red-badger.com", subject: "Incident Resolved")
  end
end
