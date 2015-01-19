module Rubevent
  describe Metrics do
    let(:event_loop) { EventLoop.new.start }
    subject(:metrics) { event_loop.metrics }

    context "newly created metrics" do
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
      context "tracking a running event loop" do
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

        it "should track events processed by event type" do
          sleep 0.1 until metrics.loop_size == 0
          event1s = metrics.events_processed "event1"
          expect(event1s).to be 4
        end

        it "should store events received" do
          expect(metrics.events_received).to be 6
        end

        it "should store events received by event type" do
          expect(metrics.events_received("event2")).to be 2
        end

        it "should store listeners registered" do
          expect(metrics.num_listeners).to be 2
        end

        it "should store listeners registered by event type" do
          expect(metrics.num_listeners("event2")).to be 1
        end
      end

      context "tracking a halted event loop" do
        prepend_before(:example) { event_loop.stop }
        before(:example) {
          event_loop.listen("event1") { }
          event_loop.listen("event2") { }
          4.times { event_loop.publish "event1" }
          2.times { event_loop.publish "event2" }
        }

        it "should have a constant loop size" do
          let_event_loop_process
          expect(event_loop.metrics.loop_size).to be 6
        end

        it "should have a constant loop size by event type" do
          let_event_loop_process
          expect(event_loop.metrics.loop_size("event1")).to be 4
        end
      end
    end
  end
end
