@all @functional
Feature: get templates with params name

  Background: : create a new template
    Given I make a 'POST' request to '/templates' endpoint
    When I set the body as:
    """
    {
       "name": "My template at-04",
       "contentTemplate": "This should be at least 20 chars"
     }
    """
    When I execute the request to the endpoint
    Then I expect a '201' status code
    And I save the 'id' of 'templates'

  @delete_templates
  Scenario Outline: Get template with params name
    Given I make a 'GET' request to '/templates' with:
      | name | <name>|
    When I execute the request to the endpoint
    Then I expect a '<status>' status code
Examples:
    | name       |     status   |
    |            |     404      |
    |    rgdfg   |     404      |
    |   3243hghtr|     404      |
    |        .   |     400      |
    |    #$%$#&%/|     400      |



  @delete_templates
  Scenario Outline: Get template with params name and empty ignore case
    Given I make a 'GET' request to '/templates' with:
      | name       | My template at-04 |
      | ignoreCase |   <ignoreCase>    |
    When I execute the request to the endpoint
    Then I expect a '<status>' status code
    Examples:
      | ignoreCase   | status  |
      |              |   400   |
      |    t         |   400   |
      |   3243hghtr  |   400   |
      |        .     |   400   |
      |    #$%$#&%/  |   400   |
      |    34325     |   400   |
      |    tru       |   400   |