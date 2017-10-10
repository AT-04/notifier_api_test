@all @functional @bug
Feature: Functional post for Notification for TWITTER

  Background: Create a Channel for TWITTER
    Given I create a 'channel' with status code '200' and body as:
    """
    {
      "name": "Channel-for-TWITTER",
      "type": "TWITTER",
      "configuration": {
      "access_token": "912661821122805760-7NTyIrDHEeoa534SduWW3TQLBUaQzLm",
      "consumer_key": "KHjTQXRMRMO5N87oOVS7mR8lf",
      "consumer_secret": "LKj4G8C9FvokkBeBTrc120qKIl2oMbwLJdUYUqqkIQJIRKlHzO",
      "access_token_secret": "W47sYHdMXafd9kZK77aUEmnXaOIZDuJTrWGsV8DuPJNm8"
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
      | priority | recipients     | subject | content                           | status_code |
      | HIGH     | testing_at04   | Test1   | A testing message from notifier 1 | 200         |
      | NORMAL   | testing_at0401 | Test2   | A testing message from notifier 2 | 200         |
