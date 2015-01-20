require 'rubevent/metrics'

module Rubevent

  class EventLoopError < StandardError; end

  class EventLoop
    attr_accessor :config
    attr_reader :metrics

    def initialize(opts = {})
      @active = false
      @events = []
      @listeners = {}
      @metrics = Metrics.new

      configure opts

      @loop = Thread.new do
        loop do
          if @events.empty? || @halted
            Thread.stop
          else
            run
          end
        end
      end
    end

    def publish(event, details = {})
      check_max_queue_size
      @events.push [event, details] # array simulates pair
      @metrics.received event
      start unless @halted
    end

    def listen event_type
      check_max_listeners
      listener = Proc.new # wrap the passed block in a proc
      listeners_for(event_type).push listener
      @metrics.registered event_type
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
      return if @events.empty? || @halted
      event_type, details = @events.shift
      @metrics.mark_processed event_type
      listeners_for(event_type).each { |listener| listener.call details }
    end

    private
    def listeners_for event_type
      # ensure that the listeners for an event type is an array data structure
      @listeners[event_type] = [] unless @listeners[event_type].is_a? Array
      @listeners[event_type]
    end

    def check_max_queue_size
      max_queue_size = @config[:max_queue_size]
      error = max_queue_size && @events.size >= max_queue_size
      raise EventLoopError if error
    end

    def check_max_listeners
      max_listeners = @config[:max_listeners]
      error = max_listeners && @listeners.values.flatten.size >= max_listeners
      raise EventLoopError if error
    end

    def configure opts
      @config = {
        :max_queue_size => opts["max-queue-size".intern],
        :max_listeners => opts["max-listeners".intern]
      }
    end
  end
end
