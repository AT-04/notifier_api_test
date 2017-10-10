@all @functional @bug
Feature: Negative responses after making a post request
  Background:
    Given I create a 'channel' with status code '200' and body as:
    """
    {
      "name": "AT04_Old_Name",
      "type": "SLACK",
      "configuration": {
        "url": "https://example.com"
      },
      "onFail": "https://fail.com"
    }
    """
    And I save the 'id' of 'channels'
  @delete_channel
  Scenario Outline: Create a new channel without required params
    Given I make a 'PUT' request to '/channels/$id' endpoint
    And I set the body as:
    """
    {
      <Name>
      <Type>
      "configuration": {
        "url": "https://www.example.com/"
      }
    }
    """
    When I execute the request to the endpoint
    Then I expect a '400' status code
    And excluding 'timestamp' and 'path' the response body contains:
    """
      {
        "status": 400,
        "error": "Bad Request",
        "exception": "org.springframework.web.bind.MethodArgumentNotValidException",
        "errors": [
          <Errors>
        ],
        "message": "Bad Request"
      }
    """
    Examples:
    | Name            | Type            | Errors                                                                                                                                    |
    |                 |                 | {"field": "name","code": "name.required","defaultMessage": null}, {"field": "type","code": "NotNull","defaultMessage": "may not be null"} |
    |                 | "type":"SLACK", | {"field": "name","code": "name.required","defaultMessage": null}                                                                          |
    | "name":"AT-04", |                 | {"field": "type","code": "NotNull","defaultMessage": "may not be null"}                                                                   |
