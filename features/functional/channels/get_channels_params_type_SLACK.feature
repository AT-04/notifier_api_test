@all @functional
Feature: Functional get for channels with params type for SLACK

  Background:
    Given I make a 'POST' request to '/channels' endpoint
    When I set the body as:
    """
    {
      "name": "AT04-Slack-Demo",
      "type": "SLACK",
      "configuration": {
        "url": "https://hooks.slack.com/services/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"
      }
    }
    """
    And I execute the request to the endpoint
    Then I expect a '200' status code
    And I save the 'id' of 'channels'
  @delete_channel
  Scenario: Get channel of type SLACK
    Given I make a 'GET' request to '/channels' with:
    | type | SLACK |
    When I execute the request to the endpoint
    Then I expect a '200' status code
    And I build the response for "channels" with
    """
      {
        "onFail": null
      }
    """
    And The response body should contain the builded response
