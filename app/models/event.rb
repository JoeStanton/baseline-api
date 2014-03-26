class Event < ActiveRecord::Base
  belongs_to :service
  belongs_to :component
  belongs_to :host
  belongs_to :incident
end
