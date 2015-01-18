RSpec.describe EventLoop do
  context "when queue is empty" do
    it "sits and does nothing" do
      event_loop = EventLoop.new
      expect(event_loop.active?).to be false
    end
  end

end
