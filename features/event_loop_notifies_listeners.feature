Feature: event loop notifies listeners

  As an application generating and reacting to events
  I want an event loop to notify listeners of my published events
  So that registered listeners can react appropriately

  Scenario: a published "food" event notifies all "food" listeners
    Given an event loop
    And a "food" event
    And a listener for a "food" event
    When I add an event listener for that event
    And I publish the event
    Then the event listener is notified of the "food" event
    