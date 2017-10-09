@all @functional
Feature: created template

  Scenario: create a new template with all params
    Given I make a 'POST' request to '/templates' endpoint
    When I set the body as:
    """
    {
        "name": "Template complete",
        "subjectTemplate": "template",
        "contentTemplate": "This is a new complete template by at-04.",
        "description": "template"
     }
    """
    When I execute the request to the endpoint
    Then I expect a '201' status code
    And I save the 'id' of 'templates'
    And I capture the response to the endpoint
    Given I make a 'GET' request to '/templates/$id' endpoint
    And I execute the request to the endpoint
    Then I expect POST response is the same as GET response

