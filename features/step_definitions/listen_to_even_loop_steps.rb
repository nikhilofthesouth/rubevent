Given /^a "(.*?)" event I want to listen for$/ do |event_type|
  @event_loop = Rubevent::EventLoop.new.start
  @event_type = event_type
end

When /^I add an event listener for that event$/ do
  @event_loop.listen_for @event_type
end

Then /^the event loop registers a listener for a "(.*?)" event$/ do |event_type|
  assert @event_loop.listeners.include? event_type.to_sym
end

