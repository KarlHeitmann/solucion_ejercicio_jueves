require 'uri'
require 'net/http'
require 'json'

n = ARGV[0].to_i

def getLiveStreamers(n)
  return JSON.parse(File.read("live_streamers.json"))[0..n]
end

def getUserData(id)
  streamers = JSON.parse(File.read("complete_data.json"))
  streamer = streamers.select {|streamer| streamer["id"] == id}
  return streamer[0]
end

# data = request("https://lichess.org/api/user/{username}")
# live_streamers = getLiveStreamers(3)
live_streamers = getLiveStreamers(n)
puts live_streamers

live_streamers_full = live_streamers.map do |streamer|
  getUserData(streamer["id"])
end

print live_streamers_full
puts

