class Component < ActiveRecord::Base
  belongs_to :service
  belongs_to :host
end
