require 'spec_helper'
describe EventsController do
  before(:all) do
    @event = Event.create
  end

  describe "GET index" do
    it "renders all events" do
      get :index

      assert_response :success
      assigns events: [@event]
    end
  end

  describe "GET show" do
    it "renders the event" do
      get :show, id: @event

      assert_response :success
      assigns event: @event
    end
  end

  describe "POST event" do
    it "adds an event of the correct type" do
      Service.create(name: "Example")
      Host.create(hostname: "example-host")
      expect {
        post :create, event: {
          message: "Sample Deployment",
          type: "Deployment",
          service_slug: "example",
          host_slug: "example-host"
        }
      }.to change(Deployment, :count).by(1)
      assert_response :success
    end
  end

  describe "DELETE event" do
    it "should delete the specified event" do
      sample = Event.create
      expect {
        delete :destroy, id: sample
      }.to change(Event, :count).by(-1)

      assert_response :success
    end
  end
end
