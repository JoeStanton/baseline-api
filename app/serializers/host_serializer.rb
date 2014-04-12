class HostSerializer < ActiveModel::Serializer
  attributes(
    :hostname,
    :ip,
    :environment,
    :service,
    :created_at,
    :status,
    :latest_message
  )

  def service
    object.service.name if object.service
  end
end
