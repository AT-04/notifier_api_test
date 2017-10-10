@all @functional
Feature: Functional post for Notification for SLACK

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
  Scenario Outline: Send notification only with the necessary parameters
    Given I make a 'POST' request to '/notifications' endpoint
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
    Then I make a 'GET' request to '/notifications/$id' until the field 'notification' at 'status' is 'DELIVERED'
    Examples:
      | recipients | content                           | status_code |
      | #general   | A testing message from notifier 1 | 200         |

  @delete_channel
  Scenario Outline: Send notification with the two predetermined priorities
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
    Then I make a 'GET' request to '/notifications/$id' until the field 'notification' at 'status' is 'DELIVERED'
    Examples:
      | priority | recipients | subject | content                           | status_code |
      | HIGH     | #general   | Test1   | A testing message from notifier 1 | 200         |
      | NORMAL   | #main      | Test2   | A testing message from notifier 2 | 200         |

  @delete_channel
  Scenario Outline: Send notification with different types of channel Id data
    Given I make a 'POST' request to '/notifications' endpoint
    When I set the body with id:
    """
         {
          "channelId": <channel_id>,
          "recipients": ["<recipients>"],
          "content": "<content>"
          }
          """
    And I execute the request to the endpoint
    Then I expect a '200' status code
    And I save the 'id' of 'notification'
    Then I make a 'GET' request to '/notifications/$id' until the field 'notification' at 'status' is 'DELIVERED'
    Examples:
      | channel_id       | recipients | content                           |
      | "$channels_id"   | #general   | A testing message from notifier 1 |
      | $channels_id.5   | #general   | A testing message from notifier 2 |
      | $channels_id.435 | #general   | A testing message from notifier 3 |
      | $channels_id.645 | #general   | A testing message from notifier 4 |
      | $channels_id.999 | #general   | A testing message from notifier 5 |

  @delete_channel
  Scenario Outline: Sending notification to multiple recipients
    Given I make a 'POST' request to '/notifications' endpoint
    When I set the body with id:
    """
         {
          "channelId": $channels_id,
          "recipients": [<recipients>],
          "content": "<content>"
          }
          """
    And I execute the request to the endpoint
    Then I expect a '200' status code
    And I save the 'id' of 'notification'
    Then I make a 'GET' request to '/notifications/$id' until the field 'notification' at 'status' is 'DELIVERED'
    Examples:
      | recipients                                                                                | content                           |
      | "#recipient_one"                                                                          | A testing message from notifier 1 |
      | "#recipient_one" ,"#recipient_two"                                                        | A testing message from notifier 2 |
      | "#recipient_one" ,"#recipient_two","#recipient_three"                                     | A testing message from notifier 3 |
      | "#recipient_one" ,"#recipient_two","#recipient_three","#recipient_four"                   | A testing message from notifier 4 |
      | "#recipient_one" ,"#recipient_two","#recipient_three","#recipient_four","#recipient_five" | A testing message from notifier 5 |
