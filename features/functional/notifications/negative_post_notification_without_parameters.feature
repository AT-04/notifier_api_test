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

  @delete_channel
  Scenario Outline: Send a new notification without parameter required
    Given I make a 'POST' request to '/notifications' endpoint
    When I set the body with id:
    """
         {
          <parameter_channelID>
          <parameter_priority>
          <parameter_recipients>
          <parameter_subject>
          <parameter_content>
          }
          """
    And I execute the request to the endpoint
    Then I expect a '400' status code
    And the response body contains excluding 'timestamp':
    """
      {
        "status": 400,
        "error": "Bad Request",
        "exception": "org.springframework.web.bind.MethodArgumentNotValidException",
        "errors": [
           <error>
        ],
        "message": "Bad Request",
        "path": "/notifications"
      }
    """
    Examples:
      | parameter_channelID        | parameter_priority     | parameter_recipients         | parameter_subject   | parameter_content                             | error                                                                                                                                                                                                                                                                                                             |
      |                            | "priority" : "NORMAL", | "recipients" : ["#general"], | "subject" : "Test", | "content" : "A testing message from notifier" | {"field": "channelId","code": "channelId.required","defaultMessage": null}                                                                                                                                                                                                                                        |
      | "channelId": $channels_id, | "priority" : "NORMAL", |                              | "subject" : "Test", | "content" : "A testing message from notifier" | {"field": "recipients","code": "NotEmpty","defaultMessage": "may not be empty"},{"field": "recipients","code":"recipients.valid","defaultMessage": null}                                                                                                                                                          |
      | "channelId": $channels_id, | "priority" : "NORMAL", | "recipients" : ["#general"], | "subject" : "Test"  |                                               | {"field": "content","code": "content.required","defaultMessage": null}                                                                                                                                                                                                                                            |
      |                            |                        |                              |                     |                                               | {"field": "recipients","code": "NotEmpty","defaultMessage": "may not be empty"},{"field": "channelId","code": "channelId.required",     "defaultMessage": null},{"field": "recipients","code": "recipients.valid","defaultMessage": null},{"field": "content","code": "content.required", "defaultMessage": null} |