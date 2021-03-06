class Node < ActiveRecord::Base
  self.abstract_class = true
  enum status: [:unknown, :ok, :error]

  attr_accessor(:status_message) # transient property
  after_update :log_status_change!, if: :status_changed?

  def latest_message
    event = events.where(type: "CheckEvent").first
    event.message if event
  end

  def outgoing_edges(type = nil)
    rels = Relationship.where(source_type: self.class, source_id: id)
    rels = rels.where(type: type) if type
    rels
  end

  def outgoing(type = nil)
    outgoing_edges(type).map(&:target)
  end

  def incoming_edges(type = nil)
    rels = Relationship.where(source_type: self.class, target_id: id)
    rels = rels.where(type: type.to_s) if type
    rels
  end

  def incoming(type = nil)
    incoming_edges(type).map(&:source)
  end

  def dependencies=(deps)
    return unless deps
    deps.each { |d| Dependency.build(self, Component.find_by(name: d)) }
  end

end
