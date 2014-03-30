require 'spec_helper'
describe ApiController do
  describe "GET index" do
    it "renders the root" do
      get :index
      assert_response :success
    end
  end
end
