@all @functional
Feature: Negative post notification with templates

  Background: Create new template and new channel
    Given I make a 'POST' request to '/templates' endpoint
    When I set the body as:
    """
     {
       "name": "Template for test notification",
       "subjectTemplate": "${information}",
       "contentTemplate": "Email address. \n${email} \nwith security code: 50",
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
        "name": "Channel test resend AS:",
        "type": "SLACK",
        "configuration": {
        "url": "https://hooks.slack.com/services/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"
      }
    }
    """
    And I execute the request to the endpoint
    Then I expect a '200' status code
    And I save the 'id' of 'channels'

  @delete_channel @delete_templates
  Scenario Outline: Send a notification with several case in subject
    Given I make a 'POST' request to '/notifications' endpoint
    When I set the body with id:
      """
      {
         "channelId":$channels_id,
         "templateId":$templates_id,
         "priority":"HIGH",
         "recipients":["#general"],
         "subject":"{ <name> : \"Verify email\"}",
         "content":"{ \"email\":\"juan@jalasoft.com\"}"
      }
      """
    When I execute the request to the endpoint
    Then I expect a '<status>' status code
    And I save the 'id' of 'notification'
    Then I make a 'GET' request to '/notifications/$id' until the field 'notification' at 'status' is '<expected_status>'

    Examples:
      | name                | status | expected_status |
      | \"    information\" | 200    | FAILED          |
      | \"infortion\"       | 200    | FAILED          |
      | \"1\"               | 200    | FAILED          |
      | \"informa tion\"    | 200    | FAILED          |
      | \"information.123\" | 200    | FAILED          |
      | \"\"                | 200    | FAILED          |

  @delete_channel @delete_templates
  Scenario Outline: Send a notification with several case in content
    Given I make a 'POST' request to '/notifications' endpoint
    When I set the body with id:
      """
      {
         "channelId":$channels_id,
         "templateId":$templates_id,
         "priority":"HIGH",
         "recipients":["#general"],
         "subject":"{ \"information\" : \"Verify email\"}",
         "content":"{ <name> :\"juan@jalasoft.com\"}"
      }
      """
    When I execute the request to the endpoint
    Then I expect a '<status>' status code
    And I save the 'id' of 'notification'
    Then I make a 'GET' request to '/notifications/$id' until the field 'notification' at 'status' is '<expected_status>'


    Examples:
      | name                | status | expected_status |
      | \"    information\" | 200    | FAILED          |
      | \"infortion\"       | 200    | FAILED          |
      | \"1\"               | 200    | FAILED          |
      | \"informa tion\"    | 200    | FAILED          |
      | \"information.123\" | 200    | FAILED          |
      | \"\"                | 200    | FAILED          |
