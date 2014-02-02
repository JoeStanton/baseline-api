class Service < ActiveRecord::Base
  has_many :components
  has_many :hosts

  include Pusherable
  pusherable('updates')
end
