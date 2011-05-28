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
      font_size = comment.title.length <= 80 ? 100 : (80.0 / comment.title.length) * 200
      font_size > 100 ? 100 : font_size
    end
  end
end
