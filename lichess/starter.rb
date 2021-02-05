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

# perfiles: reducir lista a solo de los datos

puts ":::::::::::::::"

personal_data_streamers = live_streamers_full.map do |streamer|
  {
    username: streamer["username"],
    playing: streamer["playing"],
    url: streamer["url"],
    language: streamer["language"],
    nbFollowing: streamer["nbFollowing"],
    nbFollowers: streamer["nbFollowers"],
    country: streamer["profile"]["country"],
    location: streamer["profile"]["location"],
    bio: streamer["profile"]["bio"],
    firstName: streamer["profile"]["bio"],
    lastName: streamer["profile"]["bio"],
    links: streamer["profile"]["links"],
    totalPlayTime: streamer["playTime"]["total"],
    tvPlayTime: streamer["playTime"]["total"],
  }
end

puts "Lista de solo datos personales de cada streamer "
print personal_data_streamers
puts

puts "***********"
# promedio_juegos = live_streamers_full.inject {|sumaout, streamer| sumaout += streamer["perfs"].reduce(0) {|suma_in, (perfs, val)| suma_in += val["rating"] } }
# promedio_juegos = live_streamers_full.inject {|sumaout, streamer| sumaout += streamer["perfs"]["classical"]["rating"] }
promedio_juegos = live_streamers_full["perfs"]["classical"].inject {|sumaout, streamer| sumaout += streamer["rating"].to_i }
print "+++++"
print promedio_juegos
puts
# Escribir en un archivo los datos personales. Poner los datos en una tabla con bootstrap.
