@all @functional
Feature: Functional get for channels with params type for TWITTER

  Background:
    Given I make a 'POST' request to '/channels' endpoint
    When I set the body as:
    """
    {
      "name": "AT04-Twitter-Demo",
      "type": "TWITTER",
      "configuration": {
        "access_token": "912661821122805760-7NTyIrDHEeoa534SduWW3TQLBUaQzLm",
        "consumer_key": "KHjTQXRMRMO5N87oOVS7mR8lf",
        "consumer_secret": "LKj4G8C9FvokkBeBTrc120qKIl2oMbwLJdUYUqqkIQJIRKlHzO",
        "access_token_secret": "W47sYHdMXafd9kZK77aUEmnXaOIZDuJTrWGsV8DuPJNm8"
      }
    }
    """
    And I execute the request to the endpoint
    Then I expect a '200' status code
    And I save the 'id' of 'channels'
  @delete_channel
  Scenario: Get channel of type TWITTER
    Given I make a 'GET' request to '/channels' with:
    | type | TWITTER |
    When I execute the request to the endpoint
    Then I expect a '200' status code
    And I build the response for "channels" with
    """
      {
        "onFail": null
      }
    """
    And The response body should contain the builded response
