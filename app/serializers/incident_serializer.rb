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
    :hosts,
    :predicted_root_cause
  )

  def service
    {
      name: object.service.name,
      status: object.service.status
    }
  end

  def components
    object.components.map(&:name)
  end

  def hosts
    object.hosts.map(&:hostname)
  end

  def predicted_root_cause
    object.predicted_root_cause.slug if object.open?
  end
end
