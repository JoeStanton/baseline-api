class EventSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :type,
    :status,
    :message,
    :created_at,
    :incident_id,
    :service_name,
    :component_name,
    :hostname,
    :url
  )
end
