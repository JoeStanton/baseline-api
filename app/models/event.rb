class Event < ActiveRecord::Base
  belongs_to :service
  belongs_to :component
  belongs_to :host
  belongs_to :incident

  default_scope -> { order(created_at: :desc) }
  enum status: [:ok, :error, :registered, :deregistered]

  delegate :name, to: :service, prefix: true, allow_nil: true
  delegate :name, to: :component, prefix: true, allow_nil: true
  delegate :hostname, to: :host, allow_nil: true

  include Pusherable
  pusherable('updates')
end
