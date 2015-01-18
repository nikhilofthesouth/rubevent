module Rubevent
  describe EventLoop do
    context "a newly created event loop" do
      let(:event_loop) { EventLoop.new }

      it { is_expected.to_not be_active }
      it "has no events to process" do
        expect(event_loop.events).to be_empty
      end
    end

    context "an inactive event loop" do
      let(:event_loop) { EventLoop.new }

      it "should decline publish attempts with an error" do
        expect {
          event_loop.publish "event"
        }.to raise_error(EventPublishError)
        expect(event_loop.events).to be_empty
      end

      it "should decline listen attempts with an error" do
        expect {
          event_loop.listen_for "event"
        }.to raise_error(EventListenError)
        expect(event_loop.listeners).to be_empty
      end
    end

    context "an active event loop" do
      let(:event_loop) { EventLoop.new.start }

      it "should accept publish events" do
        event_loop.publish "event"
        expect(event_loop.events).to include("event")
      end

      it "should accept event listeners" do
        event_loop.listen_for "event"
        expect(event_loop.listeners).to include("event".to_sym)
      end
    end
  end
end
