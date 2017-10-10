@all @functional
Feature: Negative responses after making an incorrect request

  Background: Create a Channel for SLACK
    Given I create a 'channel' with status code '200' and body as:
    """
    {
      "name": "Channel-for-SLACK",
      "type": "SLACK",
      "configuration": {
        "url": "https://hooks.slack.com/services/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"
      }
    }
    """
    And I save the 'id' of 'channels'

  @delete_channel
  Scenario Outline: Send notification with an invalid request
    Given I make a '<request>' request to '/notifications' endpoint
    When I set the body with id:
    """
         {
          "channelId": $channels_id,
          "recipients": ["<recipients>"],
          "content": "<content>"
          }
          """
    And I execute the request to the endpoint
    Then I expect a '<status_code>' status code
    And I save the 'id' of 'notification'
    And the response body contains excluding 'timestamp':
    """
     {
       "status": <status_code>,
       "error": "Method Not Allowed",
       "exception": "org.springframework.web.HttpRequestMethodNotSupportedException",
       "message": "Request method '<request>' not supported",
       "path": "/notifications"
     }
    """
    Examples:
      | request | recipients | content                           | status_code |
      | GET     | #general   | A testing message from notifier 1 | 405         |
      | PUT     | #general   | A testing message from notifier 1 | 405         |
      | DELETE  | #general   | A testing message from notifier 1 | 405         |
