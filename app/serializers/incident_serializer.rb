class IncidentSerializer < ActiveModel::Serializer
  attributes :id, :resolved_at, :resolved_by, :root_cause
  has_one :service
  has_one :components
  has_one :hosts
end
