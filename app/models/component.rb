class Component < Node
  belongs_to :service
  belongs_to :host
  has_many :events

  include Pusherable
  pusherable('updates')

  before_save :slugify
  def slugify
    self.slug = name.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
  end

  def to_param
    slug
  end

  def dependencies=(deps)
    return unless deps
    deps.each { |d| Dependency.build(self, Component.find_by(name: d)) }
  end

  def dependencies
    outgoing(Dependency)
  end

  def log_status_change!
    CheckEvent.create(service: service, component: self, host: host, status: status, message: status_message)
  end
end
