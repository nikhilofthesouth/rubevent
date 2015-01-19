Given /^no access to an event loop$/ do
end

Given /^an event loop$/ do
  @event_loop = Rubevent::EventLoop.new.start
end

Given /^a "(.*?)" event$/ do |event_type|
  @publish_type = event_type
  @details = { :food_type => :cookie, :amount => 50 }
end

Given /^a listener for a "(.*?)" event$/ do |event_type|
  @listen_type = event_type
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

Then /^I should have a handle to the event loop$/ do
  @event_loop.active?
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
