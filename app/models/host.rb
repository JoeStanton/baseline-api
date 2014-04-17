class Host < Node
  belongs_to :service
  has_many :components
  has_many :events

  include Pusherable
  pusherable('updates')

  def to_param
    hostname
  end

  after_create :log_create!
  def log_create!
    HostEvent.create(host: self, status: :registered)
  end

  def log_status_change!
    CheckEvent.create(service: service, host: self, status: status, message: status_message)
  end

  before_destroy :log_destroy!
  def log_destroy!
    HostEvent.create(host: self, status: :deregistered)
  end
end
