require 'spec_helper'

describe Service do
  it 'should generate status change events' do
    service = Service.create(name: "Fake Service", status: "ok")
    service.update(status: "error")
    service.events.should have(1).item
    service.incidents.should have(1).item
  end
end
