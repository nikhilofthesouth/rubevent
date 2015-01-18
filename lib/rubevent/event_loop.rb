module Rubevent
  class EventPublishError < StandardError; end
  class EventLoop
    attr_reader :active
    alias_method :active?, :active
    
    def initialize
      @active = false
      @events = []
    end

    def publish event
      raise EventPublishError unless @active
      @events.push event
    end

    def events
      Array.new @events
    end

    def start
      @active = true
      self
    end
  end
end
