# coding: utf-8

require './twitter_config.rb'

class Kakui
  attr_accessor :tweet
  attr_reader :members
  def initialize
    @members = []
  end

  def join member
    @members << member
  end

  def destination
    reply_string = ""
    @members.each do |member|
      reply_string << "@" + member + " "
    end
    return reply_string
  end

  def scan tweet
    @tweet = tweet
    if descern
      case descern
      when "join"
        join(sentence[2])
      when "reply"
        reply(sentence[2])
      when "remove"
        remove(sentence[2])
      when "members"
        show_members
      end
    end
  end

  def sentence
    return @tweet.split(" ")
  end

  def descern
    if @tweet =~ /@各位 /
      return sentence[1]
    end
    return nil
  end

  def create_reply_text text
    reply_text = destination
    reply_text << text
    return reply_text
  end

  def reply text
    reply_text = create_reply_text(text)
    Twitter.update(reply_text)
  end

  def remove member
    @members.delete(member)
  end

  def create_show_members_text
    members_text = @members.to_s.delete("\"")
    return "members = #{members_text}"
  end

  def show_members
    Twitter.update(create_show_members_text)
  end
end
