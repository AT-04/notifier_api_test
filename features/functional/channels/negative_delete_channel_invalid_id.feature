@functional @bug @all
Feature: Negative responses after making a delete request by invalid id

  Scenario Outline: Can't delete a channel by id with invalid params
    Given I make a 'DELETE' request to '/channels/<Id>' endpoint
    When I execute the request to the endpoint
    Then I expect a '<status_code>' status code
    And excluding 'timestamp' and 'path' the response body contains:

    """
    {
      "status": <status_code>,
      "error": "<error>",
      "exception": "org.springframework.web.method.annotation.MethodArgumentTypeMismatchException",
      "message": "Bad Request"
    }
    """

    Examples:
      | Id    | status_code | error       |
      | abc   | 400         | Bad Request |
      | !@$   | 400         | Bad Request |
      | SDDF  | 400         | Bad Request |
      | 070./ | 400         | Bad Request |
      | 510@  | 400         | Bad Request |
      | 510.  | 400         | Bad Request |
      | 510.1 | 400         | Bad Request |
      | 510.a | 400         | Bad Request |
      | 51#$  | 400         | Bad Request |
      | 610.M | 400         | Bad Request |
      | .     | 400         | Bad Request |


  Scenario: Can't delete a channel by id with deleted id
    Given I make a 'DELETE' request to '/channels/1170' endpoint
    When I execute the request to the endpoint
    Then I expect a '404' status code


  Scenario Outline: Can't delete a channel by id with invalid params
    Given I make a 'DELETE' request to '/channels/<Id>' endpoint
    When I execute the request to the endpoint
    Then I expect a '<status_code>' status code
    And excluding 'timestamp' and 'path' the response body contains:

    """
   {
      "status": 405,
      "error": "Method Not Allowed",
      "exception": "org.springframework.web.HttpRequestMethodNotSupportedException",
      "message": "Request method 'DELETE' not supported"
   }
    """

    Examples:
      | Id   | status_code |
      |      | 405         |
      | .345 | 405         |

