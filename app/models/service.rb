class Service < Node
  attr_accessor :name, :description, :status
  #include Pusherable
  #pusherable('updates')
end
