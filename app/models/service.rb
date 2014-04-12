class Service < Node
  has_many :components
  has_many :hosts
  has_many :events
  has_many :incidents

  include Pusherable
  pusherable('updates')

  before_save :slugify

  validates :name, presence: true

  def slugify
    self.slug = name.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
  end

  def to_param
    slug
  end

  def open_incident
    incidents.open.first
  end

  def mean_time_between_failure
    return nil if incidents.count < 1
    total = 0
    previous = created_at
    incidents.each do |incident|
      total += incident.created_at - previous
      previous = incident.created_at
    end
    total / incidents.count
  end

  def mean_time_to_recovery
    return 0.minutes if incidents.count < 1
    incidents.all.map(&:duration).sum / incidents.count
  end

  def availability
    return 1 unless mean_time_between_failure
    mean_time_between_failure / (mean_time_between_failure + mean_time_to_recovery)
  end

  def dependencies
    outgoing(Dependency)
  end

  def update_components(new)
    remaining = new
    components.each do |component|
      match = remaining.select { |c| c[:name] == component.name }.first
      if match
        remaining.delete(match)
        component.update(match)
      else
        component.destroy
      end
    end
    remaining.map { |c| components.create(c) }
  end

  def log_status_change!
    CheckEvent.create(service: self, status: status, message: status_message)
  end
end
