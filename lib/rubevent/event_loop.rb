module Rubevent

  class EventLoopError < StandardError; end
  class EventPublishError < EventLoopError; end
  class EventListenError < EventLoopError; end

  # TODO: Automatic processing and monitoring
  class EventLoop
    attr_reader :active, :events, :listeners
    alias_method :active?, :active

    def initialize
      @active = false
      @events = []
      @listeners = {}
    end

    def publish(event, details = {})
      raise EventPublishError unless @active
      @events.push [event, details]
    end

    def listen event_type
      raise EventListenError unless @active
      listener = Proc.new
      listeners_for(event_type).push listener
    end

    def start
      @active = true
      self
    end

    def stop
      @active = false
    end

    def run
      raise EventLoopError unless @active
      return if @events.empty?
      event_type, details = @events.shift
      listeners_for(event_type).each { |listener| listener.call details }
    end

    private
    def listeners_for event_type
      @listeners[event_type] = [] unless @listeners[event_type].is_a? Array
      @listeners[event_type]
    end
  end
end
