@all @functional
Feature: created template

  Scenario: create a new template with invalid or empty params
    Given I make a 'POST' request to '/templates' endpoint
    When I generate 'a' letter 257 times and save
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



