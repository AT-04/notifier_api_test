@all @functional @bug
Feature: Negative responses after making a get request by id

  Scenario Outline: Can't find a channel by id with invalid params
    Given I make a 'GET' request to '/channels/<Id>' endpoint
    When I execute the request to the endpoint
    Then I expect a '400' status code
    And the response body contains excluding 'timestamp':
    """
      {
        "status": 400,
        "error": "Bad Request",
        "exception": "org.springframework.web.method.annotation.MethodArgumentTypeMismatchException",
        "message": "Bad Request",
        "path": "/channels/<Id>"
      }
    """
    Examples:
    | Id           |
    | abc          |
    | !@$          |
    | 510@         |
    | 510.         |
    | 510.1        |
    | 510.a        |
    | 0510.$       |
    | 0510.!@#$@!# |

    Scenario: Can't Find a channel with nonexistent id
      Given I make a 'GET' request to '/channels/9999999' endpoint
      When I execute the request to the endpoint
      Then I expect a '404' status code
