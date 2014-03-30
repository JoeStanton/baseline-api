require 'spec_helper'

describe CheckEvent do
  it "should not create incidents for an OK status" do
    service = Service.create(name: "Fake Service")
    CheckEvent.create(service: service, status: :ok)

    service.open_incident.should_not be_present
  end

  it "should create an incident if one does not exist" do
    service = Service.create(name: "Fake Service", status: :error)
    event = CheckEvent.create(service: service, status: :error)

    service.open_incident.should be_present
    service.open_incident.events.should == [event]
  end

  it "should join an existing incident if one exists" do
    service = Service.create(name: "Fake Service", status: :error)
    event1 = CheckEvent.create(service: service, status: :error)
    event2 = CheckEvent.create(service: service, status: :error)

    service.open_incident.should be_present
    service.open_incident.events.should match_array [event1, event2]
  end
end
