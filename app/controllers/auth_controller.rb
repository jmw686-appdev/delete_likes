class AuthController < ApplicationController
  include HTTParty

  def index
  end

  def show
    # Authenticate via OAuth
    # client = Tumblr::Client.new({
    #   :consumer_key => 't8HPidBxWsBJiEqSulRQH8AYHE3TR0GJkX7UwTCeIo6A42oQiF',
    #   :consumer_secret => 'tvVrypa7uiofA4ElpYQDda5fWaTqAdJdTUk5gtcUf0MMx2GCDx',
    #   :oauth_token => 'bESAsGAMqukZGNn0brQ3gpNpgdSjo1EkFJ4CprZW43dBirfZaH',
    #   :oauth_token_secret => '6EIqzdwTK9bERf7PIth0XP1JP6Nn5ZiFzxaACXbKsQSOEv4BoF'
    # })

    # Make the request
    # client.likes
    current_user.access_token = params.fetch("oauth_token")
    current_user.access_secret = params.fetch("oauth_verifier")
    current_user.save

    # url = "api.tumblr.com/v2/blog/#{blog-identifier}/likes?api_key=#{ENV["TUMBLR_KEY"]}"
    # res = HTTParty.get(url, {
    #   headers: {"Authorization" => "Bearer " + current_user.access_token},
    #   debug_output: STDOUT, # To show that User-Agent is Httparty
    # })
    render json:request.env["omniauth.auth"]
    # Tumblr.configure do |config|
    #   config.consumer_key = ENV["TUMBLR_KEY"]
    #   config.consumer_secret = ENV["TUMBLR_SECRET"]
    #   config.oauth_token = current_user.access_token
    #   config.oauth_token_secret = current_user.access_secret
    # end
    # client = Tumblr::Client.new
    # @likes = client.likes
  end
end
