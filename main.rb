#!/usr/bin/env ruby
require 'em-websocket'
require 'eviapi'

EM.run {
  @client = Eviapi.client

  EM::WebSocket.run(:host => "0.0.0.0", :port => 4568) do |ws|
    ws.onopen { |handshake|
      puts "WebSocket connection open"

      ws.send "Hello, you've connected to #{handshake.path}"
    }

    ws.onclose { puts "Connection closed" }

    ws.onmessage { |msg|
      puts "Received message: #{msg}"

      if msg.slice(0..3) == "auth" and msg.slice(4) == " " and msg.slice(5..msg.length-1).length > 0
        credentials = msg.slice(5..msg.length-1).split(":")
        @client.endpoint = "https://evidevjs1.evisions.com/"
        @client.client_username = credentials[0]
        @client.client_password = credentials[1]

        @client.setup
        return ws.send @client.auth
      end



      ws.send "Pong: #{msg}"
    }
  end
}