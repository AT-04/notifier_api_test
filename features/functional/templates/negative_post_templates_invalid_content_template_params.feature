@all @functional
Feature: created template

  @delete_templates
  Scenario: create a new template with invalid or empty content Template params
    Given I make a 'POST' request to '/templates' endpoint
    When I generate 'a' letter 2147483648 times and save for 'contentTemplate' field
    And I set the body with name:
    """
     {
        "name": "name at-04",
        "subjectTemplate": "template1",
        "contentTemplate": $contentTemplate,
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
                "field": "contentTemplate",
                "code": "Size",
                "defaultMessage": "size must be between 20 and 2147483647"
            }
        ],
        "message": "Bad Request",
        "path": "/templates"
     }
    """


  @delete_templates
  Scenario Outline: Create a new template with invalid or empty contentTemplate
    Given I make a 'POST' request to '/templates' endpoint
    And I set the body as:
    """
    {
        "name": "template at-04 team",
        "subjectTemplate": "test_template",
        "contentTemplate": "<contentTemplate>",
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
              "field": "contentTemplate",
              "code": "Size",
              "defaultMessage": "size must be between 20 and 2147483647"
          }
      ],
      "message": "Bad Request",
      "path": "/templates"
    }
    """

    Examples:
      | contentTemplate |
      | trfg            |
      |                 |
      | $               |
      | 1               |
      | .               |
      | 22              |


  @delete_templates
  Scenario: Create a new template without content Template params
    Given I make a 'POST' request to '/templates' endpoint
    And I set the body as:
    """
     {
        "name": "template at-04 team",
        "subjectTemplate": "test_template",
        "description": "template"
     }
    """
    When I execute the request to the endpoint
    Then I expect a '400' status code
    And I save the 'id' of 'templates'
    And  the response body contains excluding 'timestamp':
    """
  {
      "timestamp": 1507651901739,
      "status": 400,
      "error": "Bad Request",
      "exception": "org.springframework.web.bind.MethodArgumentNotValidException",
      "errors": [
          {
              "field": "contentTemplate",
              "code": "NotNull",
              "defaultMessage": "may not be null"
          }
      ],
      "message": "Bad Request",
      "path": "/templates"
   }
    """


  @delete_templates
  Scenario Outline: Create a new template with invalid or empty contentTemplate values
    Given I make a 'POST' request to '/templates' endpoint
    And I set the body as:
    """
    {
        "name": "template at-04 team",
        "subjectTemplate": "test_template",
        "contentTemplate": "<contentTemplate>",
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
      | contentTemplate           |
      | "                      "  |
      | ....................      |
      | "                      ." |
