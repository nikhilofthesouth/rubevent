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

    def listen event_type
      raise EventListenError unless @active
      listener = Proc.new { yield }
      @listeners[event_type] = [listener]
    end
    
    def start
      @active = true
      self
    end

    def run
      event = @events.shift
      @listeners[event].each { |listener| listener.call }
    end
  end
end
