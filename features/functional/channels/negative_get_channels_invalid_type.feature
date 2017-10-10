@all @functional
Feature: Negative request get channels with invalid type

  Background:
    Given I make a 'POST' request to '/channels' endpoint
    When I set the body as:
    """
    {
      "name": "AT04-Web-Hook-Demo",
      "type": "WEB_HOOK",
      "configuration": {
        "url": "https://hooks.slack.com/services/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"
      }
    }
    """
    And I execute the request to the endpoint
    Then I expect a '200' status code
    And I save the 'id' of 'channels'
  @delete_channel @bug
  Scenario Outline: Get channel of invalid and empty type
    Given I make a 'GET' request to '/channels' with:
    | type | <Type> |
    When I execute the request to the endpoint
    Then I expect a '400' status code
    And the response body contains excluding 'timestamp':
    """
      {
        "status": 400,
        "error": "Bad Request",
        "exception": "org.springframework.web.method.annotation.MethodArgumentTypeMismatchException",
        "message": "Bad Request",
        "path": "/channels"
      }
    """
    Examples:
    | Type    |
    | ANOTHER |
    |         |
    | $       |
  @delete_channel @bug
  Scenario: Get channel of name empty
    Given I make a 'GET' request to '/channels' with:
    | name |  |
    When I execute the request to the endpoint
    Then I expect a '400' status code
    And the response body contains excluding 'timestamp':
    """
      {
        "status": 400,
        "error": "Bad Request",
        "exception": "org.springframework.web.method.annotation.MethodArgumentTypeMismatchException",
        "message": "Bad Request",
        "path": "/channels"
      }
    """
  @delete_channel
  Scenario: Get channel with nonexistent name
    Given I make a 'GET' request to '/channels' with:
    | name | Bad Name |
    When I execute the request to the endpoint
    Then I expect a '404' status code
    And I expect that the GET response it is empty
    And the response body contains excluding 'timestamp':
    """
    """
  @delete_channel @bug
  Scenario Outline: Get channel with invalid name and ignoreCase
    Given I make a 'GET' request to '/channels' with:
    | name       | <Name> |
    | ignoreCase | <Case> |
    When I execute the request to the endpoint
    Then I expect a '400' status code
    And the response body contains excluding 'timestamp':
    """
      {
        "status": 400,
        "error": "Bad Request",
        "exception": "org.springframework.web.method.annotation.MethodArgumentTypeMismatchException",
        "message": "Bad Request",
        "path": "/channels"
      }
    """
    Examples:
    | Name               | Case  |
    | AT04-Web-Hook-Demo |       |
    | AT04-Web-Hook-Demo | a     |
    |                    | true  |
    |                    |       |
    |                    | false |

  @delete_channel
  Scenario Outline: Get channel with nonexistent name and valid ignoreCase
    Given I make a 'GET' request to '/channels' with:
    | name       | <Name> |
    | ignoreCase | <Case> |
    When I execute the request to the endpoint
    Then I expect a '404' status code
    And I expect that the GET response it is empty
    And the response body contains excluding '':
    """
    """
    Examples:
    | Name      | Case  |
    | NoTExists | true  |
    | NoTExists | false |
