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
      # 85 character string should be 5em in size
      area = 85 * (5 ** 2)
      Math.sqrt(area.to_f / comment.title.length)
    end
  end
end
