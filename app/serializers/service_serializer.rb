class ServiceSerializer < ActiveModel::Serializer
  attributes :name, :slug, :status, :description, :dependencies, :components, :url, :graphite_path
  has_many :hosts

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
