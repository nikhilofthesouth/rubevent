Given /^no access to an event loop$/ do
end

Given /^an event loop$/ do
  @event_loop = Rubevent::EventLoop.new.start
end

Given /^a "(.*?)" event$/ do |event_type|
  @event = event_type
end

Given /^a listener for a "(.*?)" event$/ do |event_type|
  @event_listener = event_type
end

When /^I create an event loop$/ do
  @event_loop = Rubevent::EventLoop.new.start
end

When /^I publish the event$/ do
  @event_loop.publish @event
end

When /^I add an event listener for that event$/ do
  @notified = false
  @event_loop.listen @event_listener do
    @notified = true
  end
end

Then /^I should have a handle to the event loop$/ do
  @event_loop.active?
end

Then /^event loop should process a "(.*?)" event$/ do |event_type|
  assert @event_loop.events.include? event_type
end

Then /^the event loop registers a listener for a "(.*?)" event$/ do |event_type|
  assert @event_loop.listeners.include? event_type
end

Then /^the event listener is notified of the "(.*?)" event$/ do |event_type|
  @event_loop.run
  assert @notified
end
