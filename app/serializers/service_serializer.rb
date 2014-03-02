class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :dependencies

  def dependencies
    object.dependencies.map(&:id)
  end
end
