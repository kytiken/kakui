# coding: utf-8

require './twitter_config.rb'

class Kakui
  attr_reader :members
  def initialize
    @members = []
  end

  def join member
    @members << member
  end

  def destination
    repry_string = ""
    @members.each do |member|
      repry_string << "@" + member + " "
    end
    return repry_string
  end

  def scan tweet
    if descern(tweet)
      case descern(tweet)
      when "join"
        sentence = tweet.split(" ")
        join(sentence[2])
      when "repry"
        sentence = tweet.split(" ")
        repry(sentence[2])
      end
      
    end
  end

  def descern tweet
    if tweet =~ /@各位 /
      sentence = tweet.split(" ")
      return sentence[1]
    end
    return nil
  end

  def create_repry_text text
    repry_text = destination
    repry_text << text
    return repry_text
  end

  def repry text
    repry_text = create_repry_text(text)
    Twitter.update(repry_text)
  end
end
