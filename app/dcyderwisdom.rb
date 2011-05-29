require 'sinatra'
require 'haml'
require 'feedzirra'

get '/' do
  haml :index, locals: {
      comment: Feedzirra::Feed.fetch_and_parse(
          "http://www.dcyder.com/rss/comments?limit=1"
      ).entries.first
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
