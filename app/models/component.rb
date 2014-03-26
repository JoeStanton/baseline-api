class Component < Node
  belongs_to :service
  belongs_to :host

  include Pusherable
  pusherable('updates')

  before_save :slugify
  def slugify
    self.slug = name.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
  end

  def to_param
    slug
  end

  def log_status_change!
    CheckEvent.create(service: service, component: self, host: host, status: status)
  end
end
