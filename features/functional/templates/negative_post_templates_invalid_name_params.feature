@all @functional
Feature: created template
  @delete_templates
  Scenario: create a new template with invalid or empty name params
    Given I make a 'POST' request to '/templates' endpoint
    When I generate 'a' letter 257 times and save for 'name' field
    And I set the body with name:
    """
   {
        "name": "$name",
        "subjectTemplate": "template1",
        "contentTemplate": "This is a new complete template.",
        "description": "template"
     }
    """
    When I execute the request to the endpoint
    Then I expect a '400' status code
    And I save the 'id' of 'templates'
    And the response body contains excluding 'timestamp':
    """
     {
    "status": 400,
    "error": "Bad Request",
    "exception": "org.springframework.web.bind.MethodArgumentNotValidException",
    "errors": [
        {
            "field": "name",
            "code": "Size",
            "defaultMessage": "size must be between 4 and 256"
        }
    ],
    "message": "Bad Request",
    "path": "/templates"
     }
    """


  @delete_templates
  Scenario Outline: Create a new template with invalid or empty name
    Given I make a 'POST' request to '/templates' endpoint
    And I set the body as:
    """
   {
        "name": <Name>,
        "subjectTemplate": "template1",
        "contentTemplate": "This is a new complete template.",
        "description": "template"
     }
    """
    When I execute the request to the endpoint
    Then I expect a '400' status code
    And I save the 'id' of 'templates'
    And  excluding 'timestamp' and 'exception' the response body contains:
    """
{
    "status": 400,
    "error": "Bad Request",
    "message": "Bad Request",
    "path": "/templates"
}
    """

    Examples:
      | Name         |
      |  tr          |
      | $            |
      | #$%&/(       |
      | .            |
      |              |
      |    a         |


  @delete_templates
  Scenario: Create a new template without name params
    Given I make a 'POST' request to '/templates' endpoint
    And I set the body as:
    """
   {
        "subjectTemplate": "template1",
        "contentTemplate": "This is a new complete template.",
        "description": "template"
     }
    """
    When I execute the request to the endpoint
    Then I expect a '400' status code
    And I save the 'id' of 'templates'
    And  the response body contains excluding 'timestamp':

    """
    {
    "status": 400,
    "error": "Bad Request",
    "exception": "org.springframework.web.bind.MethodArgumentNotValidException",
    "errors": [
        {
            "field": "name",
            "code": "NotNull",
            "defaultMessage": "may not be null"
        }
    ],
    "message": "Bad Request",
    "path": "/templates"
}
    """


  @delete_templates
  Scenario Outline: Create a new template with invalid or empty name
    Given I make a 'POST' request to '/templates' endpoint
    And I set the body as:
    """
   {
        "name": <Name>,
        "subjectTemplate": "template1",
        "contentTemplate": "This is a new complete template.",
        "description": "template"
     }
    """
    When I execute the request to the endpoint
    Then I expect a '400' status code
    And I save the 'id' of 'templates'
    And  excluding 'timestamp' and 'exception' the response body contains:
    """
{
    "status": 400,
    "error": "Bad Request",
    "errors": [
        {
            "field": "name",
            "code": "Size",
            "defaultMessage": "size must be between 4 and 256"
        }
    ],
    "message": "Bad Request",
    "path": "/templates"
}

    """

    Examples:
       | Name         |
       |  "sd"        |
       | 1            |




     @delete_templates
  Scenario: Create a new template with invalid or empty name
    Given I make a 'POST' request to '/templates' endpoint
    And I set the body as:
    """
   {
        "name": "     ",
        "subjectTemplate": "template1",
        "contentTemplate": "This is a new complete template.",
        "description": "template"
     }
    """
    When I execute the request to the endpoint
    Then I expect a '400' status code
    And I save the 'id' of 'templates'
    And  excluding 'timestamp' and 'exception' the response body contains:
    """
{
    "status": 400,
    "error": "Bad Request",
    "errors": [
        {
            "field": "name",
            "code": "name.required",
            "defaultMessage": null
        }
    ],
    "message": "Bad Request",
    "path": "/templates"
}

    """
