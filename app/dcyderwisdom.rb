require 'sinatra'
require 'haml'
require 'feedzirra'

get '/' do
  feed = Feedzirra::Feed.fetch_and_parse(
      "http://www.dcyder.com/rss/comments?limit=1"
  )

  return error(haml(:feed_error)) unless feed

  haml :index, locals: {
      comment: feed.entries.first
  }
end

module Sinatra
  module Helpers
    def font_size_for comment
      # for an 85 character string, the font size should be 5em.
      # the 2d area of a each character is it's size ** its height:width ratio (approx 1.75...)
      # the total physical area available is 85 * 2d font size
      area = 85 * (5 ** 1.75)
      Math.sqrt(area.to_f / comment.title.length)
    end
  end
end
