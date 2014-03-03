class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :description, :dependencies
  has_many :hosts

  def dependencies
    object.dependencies.map(&:id)
  end
end
