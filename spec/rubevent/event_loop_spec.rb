module Rubevent
  describe EventLoop do
    context "a newly created event loop" do
      let(:event_loop) { EventLoop.new }

      it "has no events to process" do
        expect(event_loop.events).to be_empty
      end
    end

    context "a halted event loop" do
      let(:event_loop) {
        event_loop = EventLoop.new
        event_loop.stop
        Thread.pass
        sleep 0.1
        event_loop
      }

      it "should not automatically process events" do
        expect(event_loop.loop.status).to eq("sleep")
      end
    end

    context "an active event loop" do
      let(:event_loop) { EventLoop.new.start }

      it "should accept publish events" do
        event_loop.publish "event"
        expect(event_loop.events.assoc "event").to_not be_nil
      end

      it "should accept event listeners" do
        event_loop.listen("event") { }
        expect(event_loop.listeners).to include("event")
      end

      it "should process events when run" do
        event_loop.publish "event"
        event_loop.run
        expect(event_loop.events).to be_empty
      end
    end
  end
end
