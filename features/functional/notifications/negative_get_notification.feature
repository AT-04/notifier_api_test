@all @crud
Feature: GET request for notification endpoint

  Background: Send a notification
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
    Then I make a 'POST' request to '/notifications' endpoint
    When I set the body with id:
      """
      {
        "channelId": $channels_id,
        "priority": "HIGH",
        "recipients": ["#general"],
        "subject": "Test API",
        "content": "A testing message from notifier."
      }
      """
    When I execute the request to the endpoint
    Then I expect a '200' status code
    And I save the 'id' of 'notification'

  @delete_channel
  Scenario Outline: Get notification with invalid id
    Given I make a 'GET' request to '/notifications/<Id>' endpoint
    When I execute the request to the endpoint
    Then I expect a '400' status code
    And the response body contains excluding 'timestamp':
    """
      {
        "status": 400,
        "error": "Bad Request",
        "exception": "org.springframework.web.method.annotation.MethodArgumentTypeMismatchException",
        "message": "Bad Request",
        "path": "/notifications/<Id>"
      }
    """
    Examples:
      | Id                      |
      | abc                     |
      | !@$                     |
      | c4d6@                   |
      | c4d6.                   |
      | c4d6.1                  |
      | c4d6.a                  |
      | c4d6.$                  |
      | c4d6f70e-a693-47be-aedf |
      | ef79dfdc-88ee           |

  @delete_channel
  Scenario Outline: Can't Find a notification with nonexistent id
    Given I make a 'GET' request to '/notifications/<Id>' endpoint
    When I execute the request to the endpoint
    Then I expect a '404' status code
    And the response body contains excluding 'timestamp':
      """
      {
        "status": 404,
        "error": "Not Found",
        "exception": "javax.persistence.EntityNotFoundException",
        "message": "Notification not found with the id: <Id>",
       "path": "/notifications/<Id>"
      }
    """
    Examples:
      | Id                                   |
      | ef79dfdc-88ee-475b-9f5d-deb532cf3988 |
      | c4d6f70e-a693-47be-aedf-2b912e9f3e12 |


  @delete_channel @bug
  Scenario Outline: Get notification with valid id followed by a period plus one letter
    Given I make a 'GET' request to '/notifications/<Id>' endpoint
    When I execute the request to the endpoint
    Then I expect a '<status_code>' status code
    And excluding 'timestamp' and 'path' the response body contains:
      """
      {
        "status": 406,
        "error": "Not Acceptable",
        "exception": "org.springframework.web.HttpMediaTypeNotAcceptableException",
        "message": "Not Acceptable"
      }
    """
    Examples:
      | Id    | status_code |
      | $id.a | 200         |
      | $id.b | 200         |
      | $id.c | 406         |
      | $id.d | 200         |
      | $id.e | 200         |
      | $id.f | 406         |
      | $id.g | 200         |
      | $id.h | 406         |
      | $id.i | 200         |
      | $id.j | 200         |
      | $id.k | 200         |
      | $id.l | 200         |
      | $id.m | 200         |
      | $id.n | 200         |
#     | $id.ñ | 200         |
      | $id.o | 200         |
      | $id.p | 406         |
      | $id.q | 200         |
      | $id.r | 200         |
      | $id.s | 406         |
      | $id.t | 406         |
      | $id.u | 200         |
      | $id.v | 200         |
      | $id.w | 200         |
      | $id.x | 200         |
      | $id.y | 200         |
      | $id.z | 406         |
      | $id.A | 200         |
      | $id.B | 200         |
      | $id.C | 406         |
      | $id.D | 200         |
      | $id.E | 200         |
      | $id.F | 406         |
      | $id.G | 200         |
      | $id.H | 406         |
      | $id.I | 200         |
      | $id.J | 200         |
      | $id.K | 200         |
      | $id.L | 200         |
      | $id.M | 200         |
      | $id.N | 200         |
#     | $id.Ñ | 200         |
      | $id.O | 200         |
      | $id.P | 406         |
      | $id.Q | 200         |
      | $id.R | 200         |
      | $id.S | 406         |
      | $id.T | 406         |
      | $id.U | 200         |
      | $id.V | 200         |
      | $id.W | 200         |
      | $id.X | 200         |
      | $id.Y | 200         |
      | $id.Z | 406         |

  @delete_channel @bug
  Scenario Outline: Get notification with valid id followed by a period plus one number
    Given I make a 'GET' request to '/notifications/<Id>' endpoint
    When I execute the request to the endpoint
    Then I expect a '<status_code>' status code
    And excluding 'timestamp' and 'path' the response body contains:
      """
      {
        "status": 406,
        "error": "Not Acceptable",
        "exception": "org.springframework.web.HttpMediaTypeNotAcceptableException",
        "message": "Not Acceptable"
      }
    """
    Examples:
      | Id     | status_code |
      | $id.1  | 200         |
      | $id.2  | 200         |
      | $id.3  | 406         |
      | $id.4  | 200         |
      | $id.5  | 200         |
      | $id.6  | 406         |
      | $id.7  | 200         |
      | $id.8  | 406         |
      | $id.9  | 200         |
      | $id.10 | 200         |
