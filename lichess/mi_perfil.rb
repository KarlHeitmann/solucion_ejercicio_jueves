require 'uri'
require 'net/http'
require 'json'

url = URI("https://lichess.org/api/user/kheitmann")
http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
request = Net::HTTP::Get.new(url)
response = http.request(request)

puts response.read_body
