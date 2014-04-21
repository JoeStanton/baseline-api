class ComponentSerializer < ActiveModel::Serializer
  attributes(
    :name,
    :slug,
    :description,
    :type,
    :version,
    :created_at,
    :status,
    :latest_message,
    :dependencies
  )

  def dependencies
    object.dependencies.map(&:slug)
  end
end
