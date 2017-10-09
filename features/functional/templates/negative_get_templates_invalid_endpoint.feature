@functional @all
Feature: get templates with invalid endpoint

  Background: create a new template
    Given I make a 'POST' request to '/templates' endpoint
    When I set the body as:
    """
   {
       "name": "Template for update",
       "contentTemplate": "This should be at least 20 chars"
     }
    """
    When I execute the request to the endpoint
    Then I expect a '201' status code
    And I save the 'id' of 'templates'

  @delete_templates
  Scenario Outline: Can't find a template with invalid endpoint
    Given I make a 'GET' request to '/<Endpoint>/$id' endpoint
    When I execute the request to the endpoint
    Then I expect a '200' status code
    And the response body contains excluding 'timestamp':
    """
      {
       "timestamp": 1507389627623,
        "status": 404,
        "error": "Not Found",
        "message": "Not Found",
       "path": "/api/<Endpoint>/$id"
      }
    """
    Examples:
      | Endpoint        |
      | template        |
      | template123     |
      | .               |
      | TEMPLATES       |
      | teeemmplllates  |
      |                 |
      | template24!@#$@!|
