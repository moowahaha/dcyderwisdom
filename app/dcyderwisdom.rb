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
