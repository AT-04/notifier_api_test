@all @functional @bug
Feature: Negative post notification with templates

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
    Then I make a 'GET' request to '/notifications/$id' until the field 'notification' at 'status' is 'FAILED'

