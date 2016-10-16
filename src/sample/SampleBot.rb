#!/usr/bin/env ruby
# coding: utf-8

Slack.configure {|config|
  config.token = ENV['SLACK_TOKEN']
}
client = Slack.realtime

start_time = Time.now.to_i
client.on :message do |data|
  post_time = data["ts"].sub(/\..*$/, "").to_i
  next if post_time < start_time

  msg = data["text"]
  if msg =~ /^今日も一日/
    param = { 
      token:   ENV['SLACK_TOKEN'],
      channel: data["channel"],
      text:    'がんばるぞい! ',
      username: '涼風青葉＠イーグルジャンプ',
      icon_url: 'http://newgame-anime.com/assets/special/twticon/ng_icon_1.jpg'
    }   
    Slack.chat_postMessage(param)
  end 
end
client.start
