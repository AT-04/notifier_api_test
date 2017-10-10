@all @functional
Feature: Negative responses after making a post request

  Background: Send a notification
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
    Then I make a 'POST' request to '/notifications' endpoint
    When I set the body with id:
      """
      {
        "channelId": $channels_id,
        "priority": "HIGH",
        "recipients": ["#recipient_one","#recipient_two"],
        "subject": "Test API",
        "content": "A testing message from notifier."
      }
      """
    When I execute the request to the endpoint
    Then I expect a '200' status code
    And I save the 'id' of 'notification'
    Then I make a 'GET' request to '/notifications/$id' until the field 'notification' at 'status' is 'DELIVERED'

  @delete_channel
  Scenario Outline: Resend notification with non-existent recipient in the notification for resend.
    Given I make a 'POST' request to '/notifications/events/$id/resend' with:
      | recipient | <name_of_recipient> |
    When I execute the request to the endpoint
    Then I expect a '404' status code
    And excluding 'timestamp' and 'path' the response body contains:
    """
      {
        "status": 404,
        "error": "Not Found",
        "exception": "javax.persistence.EntityNotFoundException",
        "message": "The recipient '<name_of_recipient>' was not found in the notification recipients."
      }
    """
    Examples:
      | name_of_recipient                          |
      | #non_existent_recipient                    |
      | #random_recipient                          |
      | #non_existent_recipient, #random_recipient |

  @delete_channel
  Scenario Outline: Resend notification with non-existent recipient in the notification for resend.
    Given I make a 'POST' request to '/notifications/events/$id/resend' with:
      | recipient | <name_of_recipient> |
    When I execute the request to the endpoint
    Then I expect a '404' status code
    And excluding 'timestamp' and 'path' the response body contains:
    """
      {
        "status": 404,
        "error": "Not Found",
        "exception": "javax.persistence.EntityNotFoundException",
        "message": "The recipient '<name_of_recipient>' was not found in the notification recipients."
      }
    """
    Examples:
      | name_of_recipient                          |
      | #non_existent_recipient                    |
      | #random_recipient                          |
      | #non_existent_recipient, #random_recipient |