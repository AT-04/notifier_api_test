@functional @all
Feature: delete channel

  Background:
    Given I make a 'POST' request to '/channels' endpoint
    When I set the body as:
    """
    {
      "name": "AT04-Web-Hook-Demo",
      "type": "WEB_HOOK",
      "configuration": {
        "url": "https://hooks.slack.com/services/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"
      }
    }
    """
    And I execute the request to the endpoint
    Then I expect a '200' status code
    And I save the 'id' of 'channels'


  Scenario Outline: Can't delete a channel with invalid endpoint
    Given I make a 'DELETE' request to '/<Endpoint>/$id' endpoint
    When I execute the request to the endpoint
    Then I expect a '200' status code
    And the response body contains excluding 'timestamp':
    """
      {
       "timestamp": 1507389627623,
        "status": 404,
        "error": "Not Found",
        "message": "Not Found",
       "path": "/api/<Endpoint>/$id"
      }
    """
    Examples:
      | Endpoint        |
      | chanel          |
      | chanels         |
      | channel         |
      | CHANNELS        |
      | channelll       |
      |                 |
      | chanel24!@#$@!# |
