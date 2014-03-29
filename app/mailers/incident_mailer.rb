class IncidentMailer < ActionMailer::Base
  default from: "incidents@joestanton.co.uk"

  def detected(incident)
    @incident = incident
    mail(
      to: "joe.stanton@red-badger.com",
      subject: "Incident ##{@incident.id} Detected - #{@incident.service.name}"
    )
  end

  def resolved(incident)
    @incident = incident
    mail(
      to: "joe.stanton@red-badger.com",
      subject: "Incident ##{@incident.id} Resolved - #{@incident.service.name}"
    )
  end
end
