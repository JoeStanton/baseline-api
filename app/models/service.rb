class Service < Node
  has_many :components
  has_many :hosts

  def dependencies
    outgoing(Dependency)
  end

  include Pusherable
  pusherable('updates')
end
