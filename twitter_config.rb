# coding: utf-8

require 'rubygems'
require 'twitter'
require 'tweetstream'

OWN_ACCOUNT_ID = ""
consumer_key = ""
consumer_secret = ""
oauth_token = ""
oauth_token_secret = ""

Twitter.configure do |config|
  config.consumer_key = consumer_key
  config.consumer_secret = consumer_secret
  config.oauth_token = oauth_token
  config.oauth_token_secret = oauth_token_secret
end

TweetStream.configure do |config|
  config.consumer_key = consumer_key
  config.consumer_secret = consumer_secret
  config.oauth_token = oauth_token
  config.oauth_token_secret = oauth_token_secret
  config.auth_method = :oauth
end
