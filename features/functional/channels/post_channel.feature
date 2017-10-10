@all @functional
Feature: Post request for channels endpoint
  @delete_channel
  Scenario Outline: Create a new channel for WebHook, Email and Twitter
    Given I make a 'POST' request to '/channels' endpoint
    And I set the body as:
    """
    {
      "name": "<Name>",
      "type": "<Type>",
      "configuration": {
        <Configuration>
      }
    }
    """
    When I execute the request to the endpoint
    Then I expect a '200' status code
    And I save the 'id' of 'channels'
    And I build the response for "channel" with
    """
      {
        "onFail": <OnFail>
      }
    """
    And The response body is the same as builded
    Examples:
    | Name              | Type     | Configuration                                                                                | OnFail |
    | AT04-WebHook-Demo | WEB_HOOK | "url": "https://hooks.slack.com"                                                              | null   |
    | AT04-Email-Demo   | EMAIL    | "mail.from":"example@jalasoft.com", "mail.host":"127.0.0.1"                                  | null   |
    | AT04-Twitter-Demo | TWITTER  | "access_token": "a", "consumer_key": "b", "consumer_secret": "c", "access_token_secret": "d" | null   |

  @delete_channel
  Scenario Outline: Create a new channel for WebHook, Email and Twitter with all neccesary params
    Given I make a 'POST' request to '/channels' endpoint
    And I set the body as:
    """
    {
      "name": "<Name>",
      "type": "<Type>",
      "configuration": {
        <Configuration>
      },
      "onFail": "<OnFail>"
    }
    """
    When I execute the request to the endpoint
    Then I expect a '200' status code
    And I save the 'id' of 'channels'
    And I build the response for "channel" with
    """
      {
      }
    """
    And The response body is the same as builded
    Examples:
    | Name              | Type     | Configuration                                                                                | OnFail                                                                        |
    | AT04-Slack-Demo   | SLACK    | "url": "https://hooks.slack.com/services"                                                    | https://hooks.slack.com                                                       |
    | AT04-WebHook-Demo | WEB_HOOK | "url": "https://hooks.slack.com/services"                                                    | https://hooks.slack.com                                                       |
    | AT04-Email-Demo   | EMAIL    | "mail.from":"example@jalasoft.com", "mail.host":"127.0.0.1"                                  | https://hooks.slack.com/services/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 |
    | AT04-Twitter-Demo | TWITTER  | "access_token": "a", "consumer_key": "b", "consumer_secret": "c", "access_token_secret": "d" | https://hooks.slack.com                                                       |
