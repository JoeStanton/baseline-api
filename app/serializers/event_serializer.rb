class EventSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :type,
    :status,
    :repo,
    :branch,
    :author,
    :message,
    :created_at,
    :incident_id,
    :service_name,
    :component_name,
    :hostname,
    :url
  )
end
