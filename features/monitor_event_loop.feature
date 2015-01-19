Feature: monitor event loop

  As an application interested in the health of my event loop
  I want to be able to monitor its size and throughput
  So that I can make adjustments to my usage in the future

  Scenario: very high throughput
    Given an event loop
    And many events
    And several event listeners
    When I add those event listeners
    And I publish those events
    And I run the event loop
    Then I can access metrics for my event loop usage
