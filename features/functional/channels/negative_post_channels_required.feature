@all @functional @bug
Feature: Negative responses after making a post request
  @delete_channel
  Scenario Outline: Create a new channel without required params
    Given I make a 'POST' request to '/channels' endpoint
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
    And I save the 'id' of 'channels'
    And the response body contains excluding 'timestamp':
    """
      {
        "status": 400,
        "error": "Bad Request",
        "exception": "org.springframework.web.bind.MethodArgumentNotValidException",
        "errors": [
          <Errors>
        ],
        "message": "Bad Request",
        "path": "/channels"
      }
    """
    Examples:
    | Name            | Type            | Errors                                                                                                                                    |
    |                 |                 | {"field": "name","code": "name.required","defaultMessage": null}, {"field": "type","code": "NotNull","defaultMessage": "may not be null"} |
    |                 | "type":"SLACK", | {"field": "name","code": "name.required","defaultMessage": null}                                                                          |
    | "name":"AT-04", |                 | {"field": "type","code": "NotNull","defaultMessage": "may not be null"}                                                                   |
