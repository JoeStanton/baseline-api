class Service < Node
  has_many :components
  has_many :hosts

  include Pusherable
  pusherable('updates')

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

  def update_components(new)
    remaining = new
    components.each do |component|
      match = remaining.select { |c| c[:name] == component.name }.first
      if match
        remaining.delete(match)
        component.update(match)
      else
        component.destroy
      end
    end
    remaining.map { |c| components.create(c) }
  end
end
