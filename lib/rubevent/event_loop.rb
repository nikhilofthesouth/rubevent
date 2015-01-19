module Rubevent

  class EventLoopError < StandardError; end

  class EventLoop
    attr_reader :events, :listeners, :loop

    def initialize
      @active = false
      @events = []
      @listeners = {}
      @loop = Thread.new do
        while true
          if @events.empty? || @halted
            Thread.stop
          else
            run
          end
        end
      end
    end

    def publish(event, details = {})
      @events.push [event, details] # array simulates pair
      start unless @halted
    end

    def listen event_type
      listener = Proc.new # wrap the passed block in a proc
      listeners_for(event_type).push listener
    end

    def start
      @halted = false
      @loop.wakeup
      self
    end

    def stop
      @halted = true
    end

    def run
      return if @events.empty?
      event_type, details = @events.shift
      listeners_for(event_type).each { |listener| listener.call details }
    end

    private
    def listeners_for event_type
      # ensure that the listeners for an event type is an array data structure
      @listeners[event_type] = [] unless @listeners[event_type].is_a? Array
      @listeners[event_type]
    end
  end
end
