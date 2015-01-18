Feature: application creates event loop

  As a program doing interesting work
  I want to have access to an event loop
  So that I can publish events
  
  Scenario: create event loop
    Given no access to an event loop
    When I create an event loop
    Then I should have a handle to the event loop

