require 'spec_helper'
describe ServicesController do
  describe "GET index" do
    it "renders all services" do
      get :index
      assert_response :success
    end
  end
end
