require 'spec_helper'

describe Service do
  it 'should generate status change events' do
    service = Service.create(name: "Fake Service", status: "ok")
    service.update(status: "error")
    service.events.should have(1).item
    service.incidents.should have(1).item
  end

  describe 'mean time between failure' do
    it 'should calculate as nil if there have been no incidents' do
      service = Service.create(name: "Fake Service", status: "ok")
      service.mean_time_between_failure.should be_nil
    end

    it 'should calculate as a timespan if there have been incidents' do
      service = Service.create(name: "Fake Service", status: "ok", created_at: 1.week.ago)
      Incident.create(service: service)
      service.mean_time_between_failure.should be_within(1.minutes).of(1.week)
    end
  end

  describe 'mean time to recovery' do
    it 'should return zero seconds if there have been no incidents' do
      service = Service.create(name: "Fake Service", status: "ok")
      service.mean_time_to_recovery.should == 0.seconds
    end

    it 'should return a timespan if there have been incidents' do
      service = Service.create(name: "Fake Service", status: "ok")
      Incident.create(service: service, status: :resolved, created_at: 1.hour.ago, resolved_at: 50.minutes.ago)
      service.mean_time_to_recovery.should be_within(1.second).of(10.minutes)
    end
  end
end
