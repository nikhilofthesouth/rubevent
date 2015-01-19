module Rubevent
  class Metrics
    def initialize
      @events_processed = {}
      @events_received = {}
      @listeners_registered = {}
    end

    def loop_size(event_type = nil)
       events_received(event_type) - events_processed(event_type)
    end

    def events_received(event_type = nil)
      calc_hash(@events_received, event_type)
    end

    def events_processed(event_type = nil)
      calc_hash @events_processed, event_type
    end

    def num_listeners(event_type = nil)
      calc_hash @listeners_registered, event_type
    end

    def mark_processed event_type
      update_hash @events_processed, event_type
    end

    def received event_type
      update_hash @events_received, event_type
    end

    def registered event_type
      update_hash @listeners_registered, event_type
    end

    private
    def update_hash(hash, key)
      if hash[key]
        hash[key] += 1
      else
        hash[key] = 1
      end
    end

    def calc_hash(hash, key)
      if key
        hash[key] || 0
      else
        hash.values.reduce 0, :+
      end
    end
  end
end
