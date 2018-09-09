class AuthController < ApplicationController

  def index
    Tumblr.configure do |config|
      config.consumer_key = ENV["TUMBLR_KEY"]
      config.consumer_secret = ENV["TUMBLR_SECRET"]
      config.oauth_token = "access_token"
      config.oauth_token_secret = "access_token_secret"
    end
  end
end
