@all @crud
Feature: get templates

  Background:
    Background:
    Given I create a 'template' with status code '201' and body as:
    """
    {
      "name": "Template 1",
      "contentTemplate": "This should be at least 20 chars"
    }
    """
    And I save the 'id' of 'templates'
  @delete_channel
  Scenario: Get all templates
    Given I make a 'GET' request to '/templates' endpoint
    When I execute the request to the endpoint
    Then I expect a '200' status code
    And I build the response for "templates" with
    """
      {
        "onFail": null
      }
    """
    And The response body should contain the builded response
