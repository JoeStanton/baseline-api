class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :status, :dependencies

  def dependencies
    object.dependencies.map(&:id)
  end
end
