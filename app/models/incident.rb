class Incident < ActiveRecord::Base
  belongs_to :service
  has_many :events

  default_scope -> { order(created_at: :desc) }

  enum status: [:open, :resolved]
  after_create :detected_notify, if: :open?
  after_save :resolved_notify, if: :resolved?

  include Pusherable
  pusherable('updates')

  def update_status!
    return true unless open?
    problems = events.where.not(status: "ok")
    ok = problems.all? { |node| node.subject.status == "ok" }
    resolve if ok
  end

  def resolve
    update(status: :resolved, resolved_at: DateTime.now)
  end

  def components
    events.includes(:component).where.not(component_id: nil).map(&:component)
  end

  def hosts
    events.includes(:host).where.not(host_id: nil).map(&:host)
  end

  def detected_notify
    IncidentMailer.detected(self).deliver
  end

  def resolved_notify
    IncidentMailer.resolved(self).deliver
  end
end
