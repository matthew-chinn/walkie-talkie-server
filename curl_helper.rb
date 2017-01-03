=begin
#Handle ruby authentication token, expedite POST requests
response = `curl http://localhost:3000 --cookie-jar cookie | grep csrf`

key = response[/content="[^(authenticity)]\S*"/]
puts "KEY: #{key}"
key = key.split("\"").last
puts "KEY: #{key}"

url = ARGV.first
params = ARGV.last 

cmd = "curl http://localhost:3000/#{url} --data \"#{params}&authenticity_token=#{key}\" --cookie cookie"
puts cmd
response = `#{cmd}`
puts "RESPONSE: #{response}"
=end

url = ARGV.first
params = ARGV.last 
#cmd = "curl http://walkie-talkie.herokuapp.com/#{url} --data \"#{params}\""
cmd = "curl http://localhost:3000/#{url} --data \"#{params}\""
res = `#{cmd}`
puts "RESPONSE: #{res}"
