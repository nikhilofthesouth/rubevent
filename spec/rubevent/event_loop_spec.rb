module Rubevent
  describe EventLoop do
    context "a newly created event loop" do
      let(:event_loop) { EventLoop.new }

      it "has no events to process" do
        expect(event_loop.metrics.loop_size).to be 0
      end

      it "has no listeners registered" do
        expect(event_loop.metrics.num_listeners).to be 0
      end
    end

    context "a halted event loop" do
      let(:event_loop) {
        event_loop = EventLoop.new
        event_loop.stop
        event_loop
      }

      it "should not automatically process events" do
        event_loop.publish "event"
        let_event_loop_process
        expect(event_loop.metrics.loop_size).to be 1
      end
    end

    context "an active event loop" do
      let(:event_loop) { EventLoop.new.start }

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
    end
  end
end

def let_event_loop_process
  Thread.pass
  sleep 0.1
end
