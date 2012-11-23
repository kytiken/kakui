# coding: utf-8

require './kakui.rb'

client = TweetStream::Client.new

kakui = Kakui.new

puts "start"
client.userstream do |status|
  if(status.user.screen_name == OWN_ACCOUNT_ID)
    kakui.scan(status.text)
  end
end
