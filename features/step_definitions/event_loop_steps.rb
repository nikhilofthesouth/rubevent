Given /^no access to an event loop$/ do
end

Given /^an event loop$/ do
  @event_loop = Rubevent::EventLoop.new
  @event_loop.stop
end

Given /^a "(.*?)" event$/ do |event_type|
  @publish_type = event_type
  @details = { :food_type => :cookie, :amount => 50 }
end

Given /^a listener for a "(.*?)" event$/ do |event_type|
  @listen_type = event_type
end

Given /^many events$/ do
  @events = []
  event_types = ["type1", "type2", "type3"]
  1000.times { @events << event_types.sample }
end

Given /^several event listeners$/ do
  @listeners = []
  event_types = ["type1", "type2", "type3"]
  25.times { @listeners << event_types.sample }
end

When /^I create an event loop$/ do
  @event_loop = Rubevent::EventLoop.new.start
end

When /^I publish the event$/ do
  @event_loop.publish @publish_type, @details
end

When /^I add an event listener for that event$/ do
  @notified = false
  @event_loop.listen @listen_type do
    @notified = true
  end
end

When /^I add those event listeners$/ do
  @listeners.each { |listener| @event_loop.listen(listener) do; end }
end

When /^I publish those events$/ do
  @events.each { |event| @event_loop.publish event }
end

When /^I run the event loop$/ do
  @event_loop.start
  @event_loop.run
end

Then /^I should have a handle to the event loop$/ do
  @event_loop.stop
end

Then /^event loop should process a "(.*?)" event$/ do |event_type|
  assert_not_nil @event_loop.events.assoc event_type
end

Then /^the event loop registers a listener for a "(.*?)" event$/ do |event_type|
  assert @event_loop.listeners.include? event_type
end

Then /^the event listener is notified of the "(.*?)" event$/ do |event_type|
  @event_loop.run
  assert @notified
end

Then /^I can access metrics for my event loop usage$/ do
  pending # express the regexp above with the code you wish you had
end
