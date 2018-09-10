class AuthController < ApplicationController
  include HTTParty
  # DIGEST  = OpenSSL::Digest::Digest.new('sha1')
  #
  # Base64.encode64(OpenSSL::HMAC.digest(DIGEST,
  #   "Secret Key", "Message"))

  def index
  end

  def show

    # render json:request.env["omniauth.auth"]
    current_user.access_token = params.fetch("oauth_token")
    current_user.access_secret = params.fetch("oauth_verifier")
    current_user.url = request.env["omniauth.auth"].fetch("uid") + '.tumblr.com'
    current_user.save

    url = "http://api.tumblr.com/v2/blog/#{current_user.url}/info?api_key=#{ENV["TUMBLR_KEY"]}"
    # url = "http://api.tumblr.com/v2/user/likes?api_key=#{ENV["TUMBLR_KEY"]}"
    # url = "http://api.tumblr.com/v2/user/info"
    @res  = HTTParty.get(url)
    sha = consumer_secret + "&" + token_secret + signature_base_string
    sha = sha.to_sha1
    req = "http://www.tumblr.com/oauth/request_token"
    @res2 = HTTParty.get(req, {
      # Authorization: OAuth realm="http://sp.example.com/",
# oauth_consumer_key="0685bd9184jfhq22",
# oauth_token="ad180jjd733klru7",
# oauth_signature_method="HMAC-SHA1",
# oauth_signature="wOJIO9A2W5mFwDgiDvZbTSMK%2FPY%3D",
# oauth_timestamp="137131200",
# oauth_nonce="4572616e48616d6d65724c61686176",
# oauth_version="1.0"
      headers: {"Authorization" =>
        "oauth_cosumer_key=" + '"' + current_user.access_token + '"' + "," +
        "oauth_token=" + '"' + current_user.access_token + '"' + "," +
        'oauth_signature_method="HMAC-SHA1"' +
        'oauth_signature="wOJIO9A2W5mFwDgiDvZbTSMK%2FPY%3D"' +
        'oauth_timestamp="137131200"' +
        'oauth_nonce="4572616e48616d6d65724c61686176"' +
        'oauth_version="1.0" '
      }
      })
  end
end
