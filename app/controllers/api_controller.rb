class ApiController < ApplicationController
  def index
    render {version: 1}.to_json
  end
end
