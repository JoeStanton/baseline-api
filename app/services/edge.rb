class Edge
  attr_reader :from, :to, :type

  def initialize(from, to, type)
    @from = from
    @to = to
    @type = type
  end
end
