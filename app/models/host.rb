class Host < ActiveRecord::Base
  belongs_to :service
  has_many :components

  def to_param
    hostname
  end
end
