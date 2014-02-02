class Host < ActiveRecord::Base
  belongs_to :service
  has_many :components
end
