@all @functional
Feature: Negative responses after making a post request with empty parameters.

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
  Scenario Outline: Send a new notification with some empty parameters
    Given I make a 'POST' request to '/notifications' endpoint
    When I set the body with id:
    """
         {
          "channelId": "<channelId>",
          "priority": "<priority>",
          "recipients": ["<recipients>"],
          "subject": "<subject>",
          "content": "<content>"
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
           {
            "field": "<field>",
            "code":  "<code>",
            "defaultMessage": null
           }
        ],
        "message": "Bad Request",
        "path": "/notifications"
      }
    """
    Examples:
      | channelId    | priority | recipients | subject | content                         | field      | code               |
      |              | NORMAL   | #general   | Test    | A testing message from notifier | channelId  | channelId.required |
      | $channels_id | NORMAL   |            | Test    | A testing message from notifier | recipients | recipients.valid   |
      | $channels_id | NORMAL   | #general   |         | A testing message from notifier | subject    | subject.required   |
      | $channels_id | NORMAL   | #general   | Test    |                                 | content    | content.required   |

  @delete_channel
  Scenario Outline: Send a new notification with subject and content empty parameters
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
    Then I expect a '400' status code
    And the response body contains excluding 'timestamp':
    """
      {
        "status": 400,
        "error": "Bad Request",
        "exception": "org.springframework.web.bind.MethodArgumentNotValidException",
            "errors": [
        {
            "field": "subject",
            "code": "subject.required",
            "defaultMessage": null
        },
        {
            "field": "content",
            "code": "content.required",
            "defaultMessage": null
        }
        ],
        "message": "Bad Request",
        "path": "/notifications"
      }
    """
    Examples:
      | priority | recipients | subject | content |
      | NORMAL   | #general   |         |         |

  @delete_channel
  Scenario Outline: Send a new notification with recipients, subject and content empty parameters
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
    Then I expect a '400' status code
    And the response body contains excluding 'timestamp':
    """
      {
        "status": 400,
        "error": "Bad Request",
        "exception": "org.springframework.web.bind.MethodArgumentNotValidException",
        "errors": [
         {
            "field": "recipients",
            "code": "recipients.valid",
            "defaultMessage": null
         },
         {
            "field": "subject",
            "code": "subject.required",
            "defaultMessage": null
         },
         {
            "field": "content",
            "code": "content.required",
            "defaultMessage": null
         }
        ],
        "message": "Bad Request",
        "path": "/notifications"
      }
    """
    Examples:
      | priority | recipients | subject | content |
      | NORMAL   |            |         |         |

  @delete_channel
  Scenario Outline: Send a new notification with channel id ,recipients, subject and content empty parameters
    Given I make a 'POST' request to '/notifications' endpoint
    When I set the body with id:
    """
         {
          "channelId": <channelId>,
          "priority": "<priority>",
          "recipients": ["<recipients>"],
          "subject": "<subject>",
          "content": "<content>"
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
          {
            "field": "channelId",
            "code": "channelId.required",
            "defaultMessage": null
          },
          {
            "field": "recipients",
            "code": "recipients.valid",
            "defaultMessage": null
          },
          {
            "field": "subject",
            "code": "subject.required",
            "defaultMessage": null
          },
          {
            "field": "content",
            "code": "content.required",
            "defaultMessage": null
          }
        ],
        "message": "Bad Request",
        "path": "/notifications"
      }
    """
    Examples:
      | channelId | priority | recipients | subject | content |
      | ""        | NORMAL   |            |         |         |
