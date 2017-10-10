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

  @delete_channel @bug
  Scenario Outline: Send a new notification with a parameter greater than 256 characters
    Given I make a 'POST' request to '/notifications' endpoint
    When I generate 'a' letter <number_of_letters> times and save for 'value' field
    When I set the body with id:
    """
         {
          "channelId": $channels_id,
          "recipients": ["<recipients>"],
           "subject": "<subject>",
          "content": "<content>"
          }
          """
    And I execute the request to the endpoint
    Then I expect a '400' status code
    And I save the 'id' of 'notification'
    And the response body contains excluding 'timestamp':
   """
     {
    "status": 400,
    "error": "Bad Request",
    "exception": "org.springframework.web.bind.MethodArgumentNotValidException",
    "errors": [
        {
            "field": "<field>",
            "code": "Size",
            "defaultMessage": "<default_message>"
        }
    ],
    "message": "Bad Request",
    "path": "/notifications"
     }
    """
    Examples:
      | recipients | subject | content                           | number_of_letters | field      | default_message                |
      | $value     | Test    | A testing message from notifier 1 | 256               | recipients | size must be between 1 and 22  |
      | $value     | Test    | A testing message from notifier 1 | 257               | recipients | size must be between 1 and 22  |
      | $value     | Test    | A testing message from notifier 1 | 300               | recipients | size must be between 1 and 22  |
      | #general   | $value  | A testing message from notifier 1 | 300               | subject    | size must be between 0 and 255 |
