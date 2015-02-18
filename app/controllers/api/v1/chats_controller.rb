class Api::V1::ChatsController < ApplicationController

  include Tubesock::Hijack

  def chat
    hijack do |tubesock|
      redis_thread = Thread.new do # listen on its own thread
        Redis.new.subscribe(params[:roomname]) do |on|
          on.message do |channel, message|
            tubesock.send_data(message)
          end
        end
      end

      tubesock.onmessage do |m| # new message from client
        Redis.new.publish(params[:roomname], m)
      end

      tubesock.onclose do
        redis_thread.kill # stop listening when client leaves
      end
    end
  end


end
