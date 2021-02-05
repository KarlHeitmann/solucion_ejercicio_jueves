require 'uri'
require 'net/http'
require 'json'

n = ARGV[0].to_i

# 1. TOMAR TODOS LOS DATOS DE LIVE STREAMER
#
# Hacer llamado a la API de acá: https://lichess.org/api#operation/teamIdUsers
# El siguiente método recibe un parámetro "n", y lee un archivo de texto
# con los datos simulados de todos los usuarios que estan transmitiendo al vivo.
# Después de leer el archivo, el método devuelve de esa lista los primeros "n"
# usuarios
#
# Reemplazar el contenido del método getLiveStream por un código similar al
# del archivo mi_perfil.rb , pero que haga el llamado a la API
# que se encuentra en la URL que se muestra al inicio de este comentario
# El resultado de la api se debe retornar en esta funcion
#
def getLiveStreamers(n)
  return JSON.parse(File.read("live_streamers.json"))[0..n]
end

live_streamers = getLiveStreamers(n)
puts live_streamers

# 2. TOMAR LOS DATOS COMPLETOS DE TODOS LOS USUARIOS COGIDOS EN EL PUNTO 1
#
# El siguiente método recibe un ID como parametro, luego lee los datos de otro archivo
# con datos simulados, escoge de esa lista el usuario cuyo ID
# coincide con el ID recibido como parámetro y lo devuelve.
# Reemplace el contenido de esta funcion para que busque los datos de la API
# que se muestra acá: https://lichess.org/api#operation/apiUser
#
def getUserData(id)
  streamers = JSON.parse(File.read("complete_data.json"))
  streamer = streamers.select {|streamer| streamer["id"] == id}
  return streamer[0]
end

live_streamers_full = live_streamers.map do |streamer|
  getUserData(streamer["id"])
end

# 3.a Tome los datos completos de los live_streamers_full,
# y filtrelos mostrando solamente los datos de perfil
# Debe generar un arreglo con los siguientes datos;
=begin
  {
    username,
    playing,
    url,
    language,
    nbFollowing,
    nbFollowers,
    country,
    location,
    bio,
    firstName,
    lastName,
    links,
    totalPlayTime,
    tvPlayTime,
  }
=end

# 3.b  De este nuevo arreglo, haga un archivo .html que contenga
# una tabla en bootstrap con los datos obtenidos a través de la API.

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
    '''
# TODO: Ponga su código acá:
dato_tmp = "Hola"
string_html += '<p>' + dato_tmp + '</p>'

string_html += '''
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

fHTML = File.open("colaborativo.html","w")
fHTML.write(string_html)
fHTML.close

# 4. Tome los datos completos de los live_streamers_full,
#
