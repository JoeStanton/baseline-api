class Incident < ActiveRecord::Base
  belongs_to :service
  has_many :events

  scope :open, -> { where(status: "open") }
  scope :resolved, -> { where(status: "resolved") }

  include Pusherable
  pusherable('updates')

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
    !open?
  end

  def components
    events.includes(:component).where.not(component_id: nil)
  end

  def hosts
    events.includes(:host).where.not(host_id: nil)
  end
end
