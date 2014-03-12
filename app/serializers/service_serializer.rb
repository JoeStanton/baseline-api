class ServiceSerializer < ActiveModel::Serializer
  attributes :name, :slug, :status, :description, :dependencies, :components, :url
  has_many :hosts

  def url
    service_url(object)
  end

  def dependencies
    object.dependencies.map(&:slug)
  end
end
