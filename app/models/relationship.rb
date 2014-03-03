class Relationship < ActiveRecord::Base
  def self.build(from, to)
    self.find_or_create_by(
      source_type: from.class.to_s,
      source_id: from.id,
      target_type: to.class.to_s,
      target_id: to.id,
      type: self.to_s
    )
  end

  def source
    source_type.constantize.find(source_id)
  end

  def target
    target_type.constantize.find(target_id)
  end
end
