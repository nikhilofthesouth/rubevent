Feature: publish to event loop

  As an application with an interesting event
  I want to publish this event to an event loop
  So that any interested parties can be notified

  Scenario: publish 'food' event
    Given a "food" event
    When I publish the event
    Then event loop should process a "food" event