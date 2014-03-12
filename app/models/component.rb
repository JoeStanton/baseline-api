class Component < ActiveRecord::Base
  self.primary_key = :name
  belongs_to :service
  belongs_to :host
end
