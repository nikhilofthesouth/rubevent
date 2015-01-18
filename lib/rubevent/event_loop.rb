class EventLoop
  attr_reader :active
  alias_method :active?, :active

  def initialize
    @active = false
  end
end
