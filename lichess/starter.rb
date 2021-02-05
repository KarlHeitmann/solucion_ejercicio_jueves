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
# promedio_juegos = live_streamers_full["perfs"]["classical"].inject {|sumaout, streamer| sumaout += streamer["rating"].to_i }
print "+++++"
# print promedio_juegos
puts
# Escribir en un archivo los datos personales. Poner los datos en una tabla con bootstrap.

string_html = '''<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">

    <title>PAGINA LICHESS ADL</title>
  </head>
  <body>
    <h1>Pagina lichess ADL Costa Rica G 47</h1>
    <table class="table">
      <thead>
        <tr>
          <th scope="col">username</th>
        </tr>
      </thead>
      <tbody>
    '''
# TODO: Ponga su código acá:
# dato_tmp = "Hola"
# string_html += '<p>' + dato_tmp + '</p>'

puts "=================="
puts personal_data_streamers[0]
puts "//////////////////"
puts personal_data_streamers[0][:username]
puts "++++++++++++++++++"

personal_data_streamers.each do |streamer|
  string_html += "<tr><td>#{streamer[:username]}</td></tr>"
  # string_html += streamer["username"] + streamer["url"]
end

=begin
string_html += personal_data_streamers.inject do |suma, streamer|
  # suma += streamer["username"] + streamer["playing"] + streamer["url"] + streamer["language"] + streamer["nbFollowing"] + streamer["nbFollowers"]
  puts streamer
  suma += streamer[:username]
end
=end

string_html += '''
      </tbody>
    </table>
    <!-- Optional JavaScript; choose one of the two! -->

    <!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

    <!-- Option 2: Separate Popper and Bootstrap JS -->
    <!--
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
    -->
  </body>
</html>
'''

fHTML = File.open("final.html","w")
fHTML.write(string_html)
fHTML.close

# 4. Tome los datos completos de los live_streamers_full,
#
