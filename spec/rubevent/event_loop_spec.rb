module Rubevent
  describe EventLoop do
    subject(:event_loop) { EventLoop.new }

    context "a newly created event loop" do
      it "has no events to process" do
        expect(event_loop.metrics.loop_size).to be 0
      end

      it "has no listeners registered" do
        expect(event_loop.metrics.num_listeners).to be 0
      end
    end

    context "a halted event loop" do
      before(:example) { event_loop.stop }

      it "should not automatically process events" do
        event_loop.publish "event"
        let_event_loop_process
        expect(event_loop.metrics.loop_size).to be 1
      end
    end

    context "an active event loop" do
      before(:example) { event_loop.start }

      it "should accept publish events" do
        event_loop.publish "event"
        expect(event_loop.metrics.events_received("event")).to_not be 0
      end

      it "should accept event listeners" do
        event_loop.listen("event") { }
        expect(event_loop.metrics.num_listeners("event")).to_not be 0
      end

      it "should process events when run" do
        event_loop.publish "event"
        event_loop.run
        expect(event_loop.metrics.loop_size).to be 0
      end

      it "should error if max queue size is reached" do
        event_loop.config[:max_queue_size] = 0
        expect {
          event_loop.publish "event"
        }.to raise_error(EventLoopError)
      end

      it "should error if max listeners is reached" do
        event_loop.config[:max_listeners] = 0
        expect {
          event_loop.listen("event") { }
        }.to raise_error(EventLoopError)
      end
    end
  end
end
