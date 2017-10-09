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
  Scenario Outline: Send notification with nonexistent priorities
    Given I make a 'POST' request to '/notifications' endpoint
    When I set the body with id:
    """
         {
         "channelId": $channels_id,
         "priority": "<priority>",
         "recipients": ["<recipients>"],
          "subject": "<subject>",
          "content": "<content>"
          }
          """
    And I execute the request to the endpoint
    Then I expect a '<status_code>' status code
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
      | priority   | recipients | subject | content                           | status_code |
      | LOW        | #general   | Test1   | A testing message from notifier 1 | 400         |
      | NOW        | #general   | Test2   | A testing message from notifier 2 | 400         |
      | LATER      | #general   | Test3   | A testing message from notifier 3 | 400         |
      | URGENCY    | #general   | Test4   | A testing message from notifier 4 | 400         |
      | IMPORTANCE | #general   | Test5   | A testing message from notifier 5 | 400         |


  @delete_channel
  Scenario Outline: Send notification with lowercase and uppercase the first letter of the priority
    Given I make a 'POST' request to '/notifications' endpoint
    When I set the body with id:
    """
         {
         "channelId": $channels_id,
         "priority": "<priority>",
         "recipients": ["<recipients>"],
          "subject": "<subject>",
          "content": "<content>"
          }
          """
    And I execute the request to the endpoint
    Then I expect a '<status_code>' status code
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
      | priority   | recipients | subject | content                           | status_code |
      | normal     | #general   | Test1   | A testing message from notifier 1 | 400         |
      | high       | #general   | Test2   | A testing message from notifier 2 | 400         |
      | Normal     | #general   | Test3   | A testing message from notifier 3 | 400         |
      | High       | #general   | Test4   | A testing message from notifier 4 | 400         |

