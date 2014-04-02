class EventSerializer < ActiveModel::Serializer
  attributes :id, :type, :status, :created_at
  has_one :service
  has_one :component
  has_one :host
  has_one :incident
end
