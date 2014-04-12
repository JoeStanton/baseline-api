class ServiceSerializer < ActiveModel::Serializer
  attributes(
    :name,
    :slug,
    :status,
    :latest_message,
    :description,
    :dependencies,
    :url,
    :graphite_path,
    :mean_time_between_failure,
    :mean_time_to_recovery,
    :availability
  )
  has_many :hosts
  has_many :components

  def url
    service_url(object)
  end

  def dependencies
    object.dependencies.map(&:slug)
  end

  def graphite_path
    polymorphic_path(object).gsub('/', '.')[1..-1]
  end
end
