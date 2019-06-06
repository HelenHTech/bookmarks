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
    Bookmark.create(params[:title], params[:bookmark_url])
    redirect '/bookmarks'
  end

  post '/delete' do
    Bookmark.delete(params[:title_delete])
    redirect '/bookmarks'
  end


  post '/update' do
    Bookmark.update(params[:bookmark_to_update], params[:title_update], params[:url_update])
    redirect '/bookmarks'
  end

  run! if app_file == $0
end
