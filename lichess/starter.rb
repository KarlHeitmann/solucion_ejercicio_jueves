require 'uri'
require 'net/http'
require 'json'

n = ARGV[0].to_i

def getLiveStreamers(n)
  url = URI("https://lichess.org/streamer/live")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(url)
  response = http.request(request)
  return JSON.parse(response.read_body)[1..10]
end

def getUserData(id)
  streamers = JSON.parse(File.read("complete_data.json"))
  streamer = streamers.select {|streamer| streamer["id"] == id}
  return streamer[0]
end

# data = request("https://lichess.org/api/user/{username}")
# live_streamers = getLiveStreamers(3)
live_streamers = JSON.parse(File.read("live_streamers.json"))[0..n]
puts live_streamers

live_streamers_full = live_streamers.map do |streamer|
  getUserData(streamer["id"])
end

print live_streamers_full
puts

