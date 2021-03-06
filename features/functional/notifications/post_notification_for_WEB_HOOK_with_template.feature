@all @functional
Feature: Post notification with templates


  Background: Create new template and new channel
    Given I make a 'POST' request to '/templates' endpoint
    When I set the body as:
    """
     {
       "name": "Template for test notification",
       "subjectTemplate": "${information}",
       "contentTemplate": "Email address. \n${email} \nwith security code: ${code}",
       "description": "Template Demo"
     }
    """
    When I execute the request to the endpoint
    Then I expect a '201' status code
    And I save the 'id' of 'templates'
    And I make a 'POST' request to '/channels' endpoint
    When I set the body as:
    """
      {
        "name": "Channel-for-WEB-HOOK",
        "type": "WEB_HOOK",
        "configuration": {
          "url": "https://hooks.slack.com/services/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"
        }
      }
    """
    And I execute the request to the endpoint
    Then I expect a '200' status code
    And I save the 'id' of 'channels'

  @delete_channel @delete_templates
  Scenario: Send a notification with template
    Given I make a 'POST' request to '/notifications' endpoint
    When I set the body with id:
      """
      {
         "channelId":$channels_id,
         "templateId":$templates_id,
         "priority":"HIGH",
         "recipients":["#general"],
         "subject":"{ \"information\" : \"Verify email\"}",
         "content":"{ \"email\":\"juan@jalasoft.com\", \"code\": 50}"
      }
      """
    When I execute the request to the endpoint
    Then I expect a '200' status code
    And I save the 'id' of 'notification'
    Then I make a 'GET' request to '/notifications/$id' until the field 'notification' at 'status' is 'DELIVERED'

