@all @functional
Feature: Functional post for Notification for WEB-HOOK

  Background: Create a Channel for WEB-HOOK
    Given I create a 'channel' with status code '200' and body as:
  """
    {
      "name": "Channel-for-WEB-HOOK",
      "type": "WEB_HOOK",
      "configuration": {
        "url": "https://hooks.slack.com/services/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"
      }
    }
    """
    And I save the 'id' of 'channels'

  @delete_channel
  Scenario Outline: Send a new notification with the two different priorities
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
    And I save the 'id' of 'notification'
    And I build the response for "notification" with
   """
      {
        "attachments": null,
        "templateId": null
      }
    """
    Then I make a 'GET' request to '/notifications/$id' until the field 'notification' at 'status' is 'DELIVERED'
    Examples:
      | priority | recipients | subject | content                           | status_code |
      | HIGH     | #general   | Test1   | A testing message from notifier 1 | 200         |
      | NORMAL   | #main      | Test2   | A testing message from notifier 2 | 200         |
