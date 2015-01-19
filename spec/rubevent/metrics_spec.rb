module Rubevent
  describe Metrics do
    context "newly created metrics" do
      subject(:metrics) { EventLoop.new.start.metrics }

      it "should have no events processed" do
        expect(metrics.events_processed).to be 0
      end

      it "should not have no listeners registered" do
        expect(metrics.num_listeners).to be 0
      end

      it "should see an empty event loop" do
        expect(metrics.loop_size).to be 0
      end
    end

    context "warmed up metrics" do
      let(:event_loop) { EventLoop.new.start }
      subject(:metrics) { event_loop.metrics }

      before(:example) {
        event_loop.listen("event1") { }
        event_loop.listen("event2") { }
        4.times { event_loop.publish "event1" }
        2.times { event_loop.publish "event2" }
      }

      it "should store events processed" do
        sleep 0.1 until metrics.loop_size == 0
        expect(metrics.events_processed).to be 6
      end

      it "should store listeners registered" do
        expect(metrics.num_listeners).to be 2
      end

      it "should track events processed by event type" do
        sleep 0.1 until metrics.loop_size == 0
        event1s = metrics.events_processed "event1"
        expect(event1s).to be 4
      end
    end
  end
end
