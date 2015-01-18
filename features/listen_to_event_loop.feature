Feature: listen to event loop

  As an application wanting to be notified of events
  I want to listen for certain kinds of events
  So that I can react to those events

  Scenario: listen for "food" events
    Given a "food" event I want to listen for
    When I add an event listener for that event
    Then the event loop registers a listener for a "food" event
