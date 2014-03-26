class Node < ActiveRecord::Base
  self.abstract_class = true
  after_update :log_status_change!, if: :status_changed?

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
end
