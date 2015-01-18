Given /^a "(.*?)" event$/ do |event_type|
  @event_loop = Rubevent::EventLoop.new.start
  @event = event_type
end

When /^I publish the event$/ do
  @event_loop.publish @event
end

Then /^event loop should process a "(.*?)" event$/ do |event_type|
  assert @event_loop.events.include? event_type
end
