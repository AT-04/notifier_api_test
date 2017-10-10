@all @functional
Feature: Negative responses after making a post request
  @delete_channel
  Scenario Outline: Create a new channel for SLACK and WEBHOOK
    Given I make a 'POST' request to '/channels' endpoint
    And I set the body as:
    """
    {
      "name": "AT04-Slack-or-WebHook-Demo",
      "type": "<Type>",
      "configuration": {
        <Configuration>
      }
    }
    """
    When I execute the request to the endpoint
    Then I expect a '400' status code
    And I save the 'id' of 'channels'
    And the response body contains excluding 'timestamp':
    """
      {
        "status": 400,
        "error": "Bad Request",
        "exception": "org.springframework.web.bind.MethodArgumentNotValidException",
        "errors": [
          {
            "field": "configuration",
            "code": "<Field>.required",
            "defaultMessage": null
          }
        ],
        "message": "Bad Request",
        "path": "/channels"
      }
    """
    Examples:
    | Type     | Configuration                              | Field |
    | SLACK    | "url": ""                                  | url   |
    | SLACK    | "url": "123.com"                           | url   |
    | SLACK    | "url": "www.example.com/"                  | url   |
    | SLACK    | "url": "https:://www.example.com/***/***/" | url   |
    | WEB_HOOK | "url": ""                                  | url   |
    | WEB_HOOK | "url": "123.com"                           | url   |
    | WEB_HOOK | "url": "www.example.com/"                  | url   |
    | WEB_HOOK | "url": "https:://www.example.com/***/***/" | url   |

  @delete_channel
  Scenario Outline: Create a new channel without name and configuration
    Given I make a 'POST' request to '/channels' endpoint
    And I set the body as:
    """
    {
      "name": "<Name>",
      "type": "EMAIL",
      "configuration": {
        <Configuration>
      }
    }
    """
    When I execute the request to the endpoint
    Then I expect a '400' status code
    And I save the 'id' of 'channels'
    And the response body contains excluding 'timestamp':
    """
      {
        "status": 400,
        "error": "Bad Request",
        "exception": "org.springframework.web.bind.MethodArgumentNotValidException",
        "errors": [
          {
            "field": "name",
            "code": "<Field_1>.required",
            "defaultMessage": null
          },
          {
            "field": "configuration",
            "code": "<Field_2>.required",
            "defaultMessage": null
          }
        ],
        "message": "Bad Request",
        "path": "/channels"
      }
    """
    Examples:
    | Name | Configuration                                   | Field_1 | Field_2 |
    |      | "mail.from":"", "mail.host":"127.0.0.1"         | name    | email   |
    |      | "mail.from":"example@gmail.com", "mail.host":"" | name    | host    |

  @delete_channel
  Scenario Outline: Create a new channel for EMAIL
    Given I make a 'POST' request to '/channels' endpoint
    And I set the body as:
    """
    {
      "name": "AT04-Email-Demo",
      "type": "EMAIL",
      "configuration": {
        <Configuration>
      }
    }
    """
    When I execute the request to the endpoint
    Then I expect a '400' status code
    And I save the 'id' of 'channels'
    And the response body contains excluding 'timestamp':
    """
      {
        "status": 400,
        "error": "Bad Request",
        "exception": "org.springframework.web.bind.MethodArgumentNotValidException",
        "errors": [
          {
            "field": "configuration",
            "code": "<Field>.required",
            "defaultMessage": null
          }
        ],
        "message": "Bad Request",
        "path": "/channels"
      }
    """
    Examples:
    | Configuration                                    | Field |
    | "mail.from":"", "mail.host":"127.0.0.1"          | email |
    | "mail.host":"127.0.0.1", "mail.from":""          | email |
    | "mail.from":"example@gmail.com", "mail.host":""  | host  |
    | "mail.host":"" , "mail.from":"example@gmail.com" | host  |

  @delete_channel
  Scenario Outline: Create a new channel for WebHook, Email and Twitter with invalid params
    Given I make a 'POST' request to '/channels' endpoint
    And I set the body as:
    """
    {
      "name": "AT04-Email-Demo",
      "type": "EMAIL",
      "configuration": {
        <Configuration>
      }
    }
    """
    When I execute the request to the endpoint
    Then I expect a '400' status code
    And I save the 'id' of 'channels'
    And the response body contains excluding 'timestamp':
    """
      {
        "status": 400,
        "error": "Bad Request",
        "exception": "org.springframework.web.bind.MethodArgumentNotValidException",
        "errors": [
          {
            "field": "configuration",
            "code": "<Field_1>.required",
            "defaultMessage": null
          },
          {
            "field": "configuration",
            "code": "<Field_2>.required",
            "defaultMessage": null
          }
        ],
        "message": "Bad Request",
        "path": "/channels"
      }
    """
    Examples:
    | Configuration                    | Field_1 | Field_2 |
    |                                  | email   | host    |
    | "mail.from":"", "mail.host":""   | email   | host    |
    | "mail.from":"1", "mail.host": "" | email   | host    |
    | "mail.from":1, "mail.host": ""   | email   | host    |
