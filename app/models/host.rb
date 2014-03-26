class Host < ActiveRecord::Base
  belongs_to :service
  has_many :components

  def to_param
    hostname
  end

  def log_status_change!
    Event.create(service: service, host: self, type: :check, status: status)
  end
end
