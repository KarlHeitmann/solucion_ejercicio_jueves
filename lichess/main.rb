require 'uri'
require 'net/http'
require 'json'

=begin

def request(url, api_key="K6j0PyEOPtrGodgBdrx5qr6Detq9L7d7Ffoi02pQ")
  url = URI("#{url}&api_key=#{api_key}")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(url)
  request["cache-control"] ='no-cache'
  request["Postman-Token"] ='2178e596-b98d-4395-bfa7-e0ac0e2df059'
  response = http.request(request)
  JSON.parse(response.read_body)
end

=end

# data = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10")

# Pagina de lichess: https://lichess.org
# Documentacion general: https://lichess.org/api
# documentacion api get live streamers: https://lichess.org/api#operation/streamerLive

def getLiveStreamers()
  url = URI("https://lichess.org/streamer/live")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(url)
  response = http.request(request)
  return JSON.parse(response.read_body)
end

# documentacion api get data de un user https://lichess.org/api#operation/apiUser
def getUserData(name_id)
  url = URI("https://lichess.org/api/user/#{name_id}")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(url)
  response = http.request(request)
  return JSON.parse(response.read_body)
end

# data = request("https://lichess.org/api/user/{username}")
live_streamers = getLiveStreamers()
puts live_streamers
fJson = File.open("live_streamers_live.json","w")
fJson.write(live_streamers.to_json)
fJson.close

complete_data = live_streamers.map do |streamer|
  getUserData(streamer["id"])
end

fJson2 = File.open("complete_data_live.json","w")
fJson2.write(complete_data.to_json)
fJson2.close

puts complete_data
