@functional @all
Feature: Post Notification with invalid endpoint

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
  Scenario Outline: Can't post a notification with invalid endpoint
    Given I make a 'POST' request to '/<Endpoint>' endpoint
    When I set the body with id:
    """
         {
          "channelId": $channels_id,
          "recipients": [<recipients>],
          "content": "<content>"
          }
          """
    And I execute the request to the endpoint
    Then I expect a '404' status code
    And the response body contains excluding 'timestamp':
    """
      {
        "status": 404,
        "error": "Not Found",
        "message": "Not Found",
       "path": "/api/<Endpoint>"
      }
    """
    Examples:
      | Endpoint          | recipients | content                           |
      | notific           | "#general" | A testing message from notifier 0 |
      | notification      | "#general" | A testing message from notifier 1 |
      | NOTIFICATIONS     | "#general" | A testing message from notifier 2 |
      | notificationsV1   | "#general" | A testing message from notifier 3 |
      | notifications1    | "#general" | A testing message from notifier 4 |
      | notifications!@   | "#general" | A testing message from notifier 5 |

