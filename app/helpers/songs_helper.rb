require 'net/http'


module SongsHelper

  def url_exist?(url_string)
    url = URI.parse url_string
    req = Net::HTTP.new(url.host, url.port)
    res = req.request_head(url.path)

    # code = RestClient.get(url_string).code
     res.code == "200"
  rescue Errno::ENOENT
    false # false if can't find the server
  end


end