module Notifiable
  extend ::ActiveSupport::Concern

  module ClassMethods
    def notifiable
      class_eval do
        if defined?(Mongoid) && defined?(Mongoid::Document) && include?(Mongoid::Document)
          after_create :trigger_create
          after_update :trigger_update
          before_destroy :trigger_destroy
        else
          after_commit :trigger_create, on: :create
          after_commit :trigger_update, on: :update
          after_commit :trigger_destroy, on: :destroy
        end

        private

        def model_name
          self.class.name.underscore
        end

        def trigger_create
          Notification.trigger("#{model_name}.create", self.to_json)
        end

        def trigger_update
          Notification.trigger("#{model_name}.update", self.to_json)
        end

        def trigger_destroy
          Notification.trigger("#{model_name}.destroy", self.to_json)
        end
      end
    end
  end
end

if defined?(ActiveRecord) && defined?(ActiveRecord::Base)
  ActiveRecord::Base.send :include, Notifiable
end

if defined?(Mongoid) && defined?(Mongoid::Document)
  Mongoid::Document.send :include, Notifiable
end
