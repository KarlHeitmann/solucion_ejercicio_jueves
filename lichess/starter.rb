require 'uri'
require 'net/http'
require 'json'

def getLiveStreamers(n)
  url = URI("https://lichess.org/streamer/live")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(url)
  response = http.request(request)
  return JSON.parse(response.read_body)[1..10]
end

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
# live_streamers = getLiveStreamers(3)
live_streamers = JSON.parse(File.read("live_streamers.json"))
puts live_streamers

complete_data = live_streamers.map do |streamer|
  getUserData(streamer["id"])
end

puts complete_data

