class Host < ActiveRecord::Base
  belongs_to :service
  has_many :components
  has_many :events

  def to_param
    hostname
  end

  after_create :log_create!
  def log_create!
    HostEvent.create(host: self, status: :create)
  end

  def log_status_change!
    Event.create(service: service, host: self, type: :check, status: status)
  end

  before_destroy :log_destroy!
  def log_destroy!
    HostEvent.create(host: self, status: :destroy)
  end
end
