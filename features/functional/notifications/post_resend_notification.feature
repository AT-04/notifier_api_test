@all @functional
Feature: Functional post for Resend Notification

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
  Scenario: Resend notification with name of recipient.
    Given I make a 'POST' request to '/notifications/events/$id/resend' with:
      | recipient | #recipient_one |
    When I execute the request to the endpoint
    Then I expect a '200' status code
    And I build the response for "notification" with
    """
      {
        "attachments": {},
        "templateId": null
      }
    """
    And The response body is the same as builded
    Then I make a 'GET' request to '/notifications/$id' until the field 'notification' at 'status' is 'RE_SENT'

  @delete_channel
  Scenario: Resend notification without name of recipient.
    Given I make a 'POST' request to '/notifications/events/$id/resend' endpoint
    When I execute the request to the endpoint
    Then I expect a '200' status code
    And I build the response for "notification" with
    """
      {
        "attachments": {},
        "templateId": null
      }
    """
    And The response body is the same as builded
    Then I make a 'GET' request to '/notifications/$id' until the field 'notification' at 'status' is 'DELIVERED'

  @delete_channel
  Scenario Outline: Resend to only one of the notification recipients.
    Given I make a 'POST' request to '/notifications/events/$id/resend' with:
      | recipient | <name_of_recipient> |
    When I execute the request to the endpoint
    Then I expect a '200' status code
    Then I make a 'GET' request to '/notifications/$id' until the field 'notification' at 'status' is 'RE_SENT'
    Examples:
      | name_of_recipient |
      | #recipient_two    |
