class IncidentSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :status,
    :created_at,
    :resolved_at,
    :resolved_by,
    :root_cause,
    :service,
    :components,
    :hosts
  )

  def components
    object.components.map(&:name)
  end

  def hosts
    object.hosts.map(&:hostname)
  end
end
