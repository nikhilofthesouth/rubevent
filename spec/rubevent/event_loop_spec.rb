module Rubevent
  describe EventLoop do
    context "a newly created event loop" do
      let(:event_loop) { EventLoop.new }

      it "sits and does nothing" do
        expect(event_loop.active?).to be false
      end

      it "has no events to process" do
        expect(event_loop.events.size).to be 0
      end
    end

    context "an inactive event loop" do
      let(:event_loop) { EventLoop.new }

      it "should decline publish attempts with an error" do
        expect {
          event_loop.publish "event"
        }.to raise_error(EventPublishError)
        expect(event_loop.events.size).to be 0
      end
    end

    context "an active event loop" do
      let(:event_loop) { EventLoop.new.start }

      it "should accept publish events" do
        event_loop.publish "event"
        expect(event_loop.events).to contain_exactly("event")
      end
    end
  end
end
