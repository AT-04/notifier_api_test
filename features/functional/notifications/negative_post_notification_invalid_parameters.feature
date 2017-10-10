@all @functional
Feature: Negative responses after making a post request

  Background: Create a Channel
    Given I create a 'channel' with status code '200' and body as:
    """
    {
      "name": "AT04-Slack-Demo-for-Notifications",
      "type": "SLACK",
      "configuration": {
        "url": "https://hooks.slack.com/services/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"
      }
    }
    """
    And I save the 'id' of 'channels'


  @delete_channel
  Scenario Outline: Send a new notification with invalid parameters
    Given I make a 'POST' request to '/notifications' endpoint
    When I set the body with id:
    """
         {
          "channelId": <channelId>,
          "priority": <priority>,
          "recipients": [<recipients>],
          "subject": "<subject>",
          "content": "<content>"
          }
          """
    And I execute the request to the endpoint
    Then I expect a '400' status code
    And the response body contains excluding 'timestamp':
    """
      {
       "status": 400,
       "error": "Bad Request",
       "exception": "org.springframework.http.converter.HttpMessageNotReadableException",
       "message": "Bad Request",
       "path": "/notifications"
      }
    """
    Examples:
      | channelId | priority | recipients | subject | content                         |
      | "One"     | "NORMAL" | recipients | Test1   | A testing message from notifier |
      | 01        | "NORMAL" | recipients | Test2   | A testing message from notifier |
      | $id       | ""       | recipients | Test3   | A testing message from notifier |
      | $id       | 5        | recipients | Test3   | A testing message from notifier |
      | $id       | "NORMAL" |            | Test3   | A testing message from notifier |

