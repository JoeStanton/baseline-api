class Incident < ActiveRecord::Base
  belongs_to :service
  has_many :events

  scope :open, -> { where(status: "open") }
  scope :resolved, -> { where(status: "resolved") }

  include Pusherable
  pusherable('updates')

  after_save :notify, if: :status_changed?

  def notify
    IncidentMailer.detected(self).deliver if open?
    IncidentMailer.resolved(self).deliver if resolved?
  end

  def update_status!
    return true unless status == "open"
    problems = events.where.not(status: "ok")
    ok = problems.all? { |node| node.subject.status == "ok" }
    resolve if ok
  end

  def resolve
    update(status: :resolved, resolved_at: DateTime.now)
  end

  def open?
    status == "open"
  end

  def resolved?
    status == "resolved"
  end

  def components
    events.includes(:component).where.not(component_id: nil).map(&:component)
  end

  def hosts
    events.includes(:host).where.not(host_id: nil).map(&:host)
  end
end
