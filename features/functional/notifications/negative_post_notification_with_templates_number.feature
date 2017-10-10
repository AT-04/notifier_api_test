@all @functional
Feature: Negative post notification with templates


  @delete_channel @delete_templates
  Scenario Outline: Create new template and new channel
    Given I make a 'POST' request to '/templates' endpoint
    When I set the body as:
    """
     {
       "name": "Template for test notification",
       "subjectTemplate": "${<name_subject>}",
       "contentTemplate": "Email address. \n${email} ",
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

    And I make a 'POST' request to '/notifications' endpoint
    When I set the body with id:
      """
      {
         "channelId":$channels_id,
         "templateId":$templates_id,
         "priority":"HIGH",
         "recipients":["#general"],
         "subject":"{ \"<name_subject>\" : \"Verify email\"}",
         "content":"{ \"email\":\"juan@jalasoft.com\"}"
      }
      """
    When I execute the request to the endpoint
    Then I expect a '<status>' status code
    And I save the 'id' of 'notification'
    Then I make a 'GET' request to '/notifications/$id' until the field 'notification' at 'status' is '<expected_status>'

    Examples:
      | name_subject   | status | expected_status |
      | information    | 200    | DELIVERED       |
      | information1   | 200    | DELIVERED       |
      | information01  | 200    | DELIVERED       |
      | @information   | 200    | DELIVERED       |
      | information!   | 200    | DELIVERED       |
      | information@   | 200    | DELIVERED       |
      | information$   | 200    | DELIVERED       |

#      failed
      | 001information | 200    | FAILED          |
      | !information   | 200    | FAILED          |
      | #information   | 200    | FAILED          |
      | %information   | 200    | FAILED          |
      | information#   | 200    | FAILED          |
      | test.04        | 200    | FAILED          |
      | test-04        | 200    | FAILED          |
      | test/04        | 200    | FAILED          |
      | test->04       | 200    | FAILED          |
      | name status    | 200    | FAILED          |
      | name_status    | 200    | DELIVERED       |
      | nameStatus     | 200    | DELIVERED       |


