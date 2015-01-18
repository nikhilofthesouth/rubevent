Given /^no access to an event loop$/ do
end

When /^I create an event loop$/ do
  @event_loop = Rubevent::EventLoop.new
end

Then /^I should have a handle to the event loop$/ do
  @event_loop.active?
end
