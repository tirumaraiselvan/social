
require 'uri'
require 'net/http'
require 'byebug'
require 'json'

screen_name = "HasuraHQ"

auth_uri = URI('https://api.twitter.com/oauth2/token')

auth_req = Net::HTTP::Post.new(auth_uri)
auth_req.set_form_data(grant_type: 'client_credentials')

auth_req['Content-Type'] = 'application/x-www-form-urlencoded;charset=UTF-8'
auth_req['Authorization'] = 'Basic xyz'

res = Net::HTTP.start(auth_uri.hostname, auth_uri.port, :use_ssl => true) do |http|
    http.request(auth_req)
    end

res = JSON.parse(res.body)

token = res["access_token"]

cursor = 1524727380465794180
api = 'https://api.twitter.com/1.1/followers/list.json?skip_status=true&screen_name=' + screen_name

while cursor != 0 do
    api_with_cursor = api + '&cursor=' + cursor.to_s
    uri = URI(api_with_cursor)
    api_req = Net::HTTP::Get.new(uri)
    api_req['Authorization'] = "Bearer " + token

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) do |http|
            http.request(api_req)
        end

    if res.code == "429"
        puts "Rate limited exceeded, cursor at: " + cursor.to_s
        break
    end
    res = JSON.parse(res.body)
    cursor = res["next_cursor"]

    res["users"].each do |user|
        if user["description"].include? screen_name 
            puts user["screen_name"]
        end
    end
end
