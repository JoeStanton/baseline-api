class Service < Node
  include ActiveModel::Model

  include Pusherable
  pusherable('updates')
end
