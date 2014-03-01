class Service < Node
  include Pusherable
  pusherable('updates')
end
