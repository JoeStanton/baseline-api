class Incident < ActiveRecord::Base
  belongs_to :service
  has_many :events

  default_scope -> { order(created_at: :desc) }

  enum status: [:open, :resolved]
  after_create :detected_notify, if: :open?
  after_save :resolved_notify, if: :resolved?

  include Pusherable
  pusherable('updates')

  delegate :name, to: :service, prefix: true, allow_nil: true

  def update_status!
    return true unless open?
    problems = events.where.not(status: "ok")
    ok = problems.all? { |node| node.subject.status == "ok" }
    resolve if ok
  end

  def duration
    (resolved_at || Time.now) - created_at
  end

  def resolve
    update(status: :resolved, resolved_at: Time.now)
  end

  def components
    events.includes(:component).where.not(component_id: nil).map(&:component).uniq
  end

  def hosts
    events.includes(:host).where.not(host_id: nil).map(&:host).uniq
  end

  def detected_notify
    IncidentMailer.detected(self).deliver
  end

  def resolved_notify
    IncidentMailer.resolved(self).deliver
  end

  def predicted_root_cause
    problems = []
    problems << service unless service.ok?
    problems << components
    problems.flatten!
    problems.find { |p| p.dependencies.all?(&:ok?) }
  end
end
