require 'spec_helper'

describe Incident do
  it "should be resolved when all problem nodes return an OK state" do
    service = Service.create(name: "Fake Service")
    service.update(status: "error")
    incident = service.open_incident
    service.update(status: "ok")

    incident.reload.should be_resolved
  end

  it "should trigger an email when detected" do
    message = double
    message.should_receive(:deliver)

    service = Service.create(name: "Fake Service")
    IncidentMailer.should_receive(:detected).and_return(message)
    Incident.create(service: service)
  end

  it "should trigger an email when resolved" do
    message = double
    message.should_receive(:deliver)

    service = Service.create(name: "Fake Service")
    incident = Incident.create(service: service)
    IncidentMailer.should_receive(:resolved).and_return(message)
    incident.resolve
  end
end
