class Service < Node
  has_many :components
  has_many :hosts

  before_save :slugify

  def slugify
    self.slug = name.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
  end

  def to_param
    slug
  end

  def dependencies
    outgoing(Dependency)
  end

  include Pusherable
  pusherable('updates')
end
