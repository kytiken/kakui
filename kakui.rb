# coding: utf-8

require './twitter_config.rb'
require './group.rb'

class Kakui
  attr_accessor :groups, :tweet

  DEFAULT_KEYWORD = '各位'

  def initialize
    @default_group = Group.new(DEFAULT_KEYWORD)
    @groups = {DEFAULT_KEYWORD => @default_group}
    @current_group = @default_group
  end

  def keywords
    return @groups.keys
  end

  def store_group keyword
    group = Group.new(keyword)
    @groups.store(keyword, group)
  end

  def members
    @current_group.members
  end

  def join member
    @current_group.members << member
  end

  def destination
    reply_string = ""
    @current_group.members.each do |member|
      reply_string << "@" + member + " "
    end
    return reply_string
  end

  def scan tweet
    @tweet = tweet
    if descern
      case descern
      when "join"
        puts "join"
        join(sentence[2])
      when "reply"
        puts "reply"
        reply(sentence[2])
      when "remove"
        puts "remove"
        remove(sentence[2])
      when "members"
        puts "members"
        show_members
      when "group"
        puts "group"
        store_group(sentence[2])
      end
    end
  end

  def sentence
    return @tweet.split(" ")
  end

  def descern
    keywords.each do |keyword|
      if @tweet.include?(@groups[keyword].identifier + " ")
        @current_group = @groups[keyword]
        return sentence[1]
      end
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
    @current_group.delete(member)
  end

  def create_show_members_text
    members_text = @current_group.members.to_s.delete("\"")
    return "members = #{members_text}"
  end

  def show_members
    Twitter.update(create_show_members_text)
  end
end
