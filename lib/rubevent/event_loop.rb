module Rubevent
  class EventPublishError < StandardError; end
  class EventListenError < StandardError; end
  class EventLoop
    attr_reader :active, :events, :listeners
    alias_method :active?, :active
    
    def initialize
      @active = false
      @events = []
      @listeners = {}
    end

    def publish event
      raise EventPublishError unless @active
      @events.push event
    end

    def listen_for event
      raise EventListenError unless @active
      @listeners[event.intern] = []
    end
    
    def start
      @active = true
      self
    end
  end
end
