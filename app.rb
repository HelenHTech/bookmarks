require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  get '/' do
    p ENV
    'Bookmark Manager'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :index
  end

  post '/adder' do
    Bookmark.create(params[:bookmark_url])
    redirect '/bookmarks'
  end

  run! if app_file == $PROGRAM_NAME
end
