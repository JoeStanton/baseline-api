class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :dependencies

  def dependencies
    object.dependencies.map(&:id)
  end
end
