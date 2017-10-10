@all @functional
Feature: Negative responses after making a post request
  @delete_channel
  Scenario Outline: Create a new channel for Twitter with invalid params
    Given I make a 'POST' request to '/channels' endpoint
    And I set the body as:
    """
    {
      "name": "AT04-Twitter-Demo",
      "type": "TWITTER",
      "configuration": {
        "access_token": "<A_Token>",
        "consumer_key": "<C_Key>",
        "consumer_secret": "<C_Secret>",
        "access_token_secret": "<A_T_Secret>"
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
          {
            "field": "configuration",
            "code": "<Code_Error>.required",
            "defaultMessage": null
          }
        ],
        "message": "Bad Request",
        "path": "/channels"
      }
    """
    Examples:
| A_Token | C_Key | C_Secret | A_T_Secret | Code_Error          |
|         | b     | c        | d          | access_token        |
|         | 2     | 3        | 4          | access_token        |
| %       | 2     | 3        | 4          | access_token        |
| a       |       | c        | d          | consumer_key        |
| 1       |       | 3        | 4          | consumer_key        |
| 1       | ^     | 3        | 4          | consumer_key        |
| a       | b     |          | d          | consumer_secret     |
| 1       | 2     |          | 4          | consumer_secret     |
| 1       | 2     | &        | 4          | consumer_secret     |
| a       | b     | c        |            | access_token_secret |
| 1       | 2     | 3        |            | access_token_secret |
| 1       | 2     | 3        | *          | access_token_secret |

 @delete_channel
  Scenario Outline: Create a new channel for Twitter with invalid params
    Given I make a 'POST' request to '/channels' endpoint
    And I set the body as:
    """
    {
      "name": "AT04-Twitter-Demo",
      "type": "TWITTER",
      "configuration": {
        "access_token": "<A_Token>",
        "consumer_key": "<C_Key>",
        "consumer_secret": "<C_Secret>",
        "access_token_secret": "<A_T_Secret>"
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
          {
            "field": "configuration",
            "code": "<First_Code_Error>.required",
            "defaultMessage": null
          },
          {
            "field": "configuration",
            "code": "<Second_Code_Error>.required",
            "defaultMessage": null
          }
        ],
        "message": "Bad Request",
        "path": "/channels"
      }
    """
    Examples:
| A_Token | C_Key | C_Secret | A_T_Secret | First_Code_Error | Second_Code_Error   |
|         |       | c        | d          | consumer_key     | access_token        |
|         |       | 3        | 4          | consumer_key     | access_token        |
| #       | $     | 3        | 4          | consumer_key     | access_token        |
| a       |       |          | d          | consumer_key     | consumer_secret     |
| 1       |       |          | 4          | consumer_key     | consumer_secret     |
| 1       | $     | %        | 4          | consumer_key     | consumer_secret     |
| a       | b     |          |            | consumer_secret  | access_token_secret |
| 1       | 2     |          |            | consumer_secret  | access_token_secret |
| 1       | 2     | %        | ^          | consumer_secret  | access_token_secret |

  @delete_channel
  Scenario Outline: Create a new channel for Twitter with invalid params
    Given I make a 'POST' request to '/channels' endpoint
    And I set the body as:
    """
    {
      "name": "AT04-Twitter-Demo",
      "type": "TWITTER",
      "configuration": {
        "access_token": "<A_Token>",
        "consumer_key": "<C_Key>",
        "consumer_secret": "<C_Secret>",
        "access_token_secret": "<A_T_Secret>"
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
          {
            "field": "configuration",
            "code": "<First_Code_Error>.required",
            "defaultMessage": null
          },
          {
            "field": "configuration",
            "code": "<Second_Code_Error>.required",
            "defaultMessage": null
          },
          {
            "field": "configuration",
            "code": "<Third_Code_Error>.required",
            "defaultMessage": null
          }
        ],
        "message": "Bad Request",
        "path": "/channels"
      }
    """
    Examples:
    | A_Token | C_Key | C_Secret | A_T_Secret | First_Code_Error | Second_Code_Error | Third_Code_Error    |
    |         |       |          | 4          | consumer_key     | consumer_secret   | access_token        |
    | 1       |       |          |            | consumer_key     | consumer_secret   | access_token_secret |
    |         | 2     |          |            | consumer_secret  | access_token      | access_token_secret |
    |         | 3     |          |            | consumer_secret  | access_token      | access_token_secret |

  @delete_channel
  Scenario Outline: Create a new channel for Twitter with invalid params
    Given I make a 'POST' request to '/channels' endpoint
    And I set the body as:
    """
    {
      "name": "AT04-Twitter-Demo",
      "type": "TWITTER",
      "configuration": {
        "access_token": "<A_Token>",
        "consumer_key": "<C_Key>",
        "consumer_secret": "<C_Secret>",
        "access_token_secret": "<A_T_Secret>"
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
          {
            "field": "configuration",
            "code": "<First_Code_Error>.required",
            "defaultMessage": null
          },
          {
            "field": "configuration",
            "code": "<Second_Code_Error>.required",
            "defaultMessage": null
          },
          {
            "field": "configuration",
            "code": "<Third_Code_Error>.required",
            "defaultMessage": null
          },
          {
            "field": "configuration",
            "code": "<Fourth_Code_Error>.required",
            "defaultMessage": null
          }
        ],
        "message": "Bad Request",
        "path": "/channels"
      }
    """
    Examples:
    | A_Token | C_Key | C_Secret | A_T_Secret | First_Code_Error | Second_Code_Error | Third_Code_Error | Fourth_Code_Error   |
    |         |       |          |            | consumer_key     | consumer_secret   | access_token     | access_token_secret |
    | #       | $     | %        | ^          | consumer_key     | consumer_secret   | access_token     | access_token_secret |
