class Service < Node
  attr_accessor :name, :description, :status

  def dependencies
    outgoing(:depends_on)
  end

  #include Pusherable
  #pusherable('updates')
end
