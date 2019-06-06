require 'pg'

# bookmark class
class Bookmark
  attr_reader :id, :title, :url

  def initialize(id, title, url)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    connection = if ENV['ENVIRONMENT'] == 'test'
                   PG.connect(dbname: 'bookmark_manager_test')
                 else
                   PG.connect(dbname: 'bookmark_manager')
                 end
    result = connection.exec('SELECT * FROM bookmarks;')
    result.map { |bookmark| Bookmark.new(bookmark['id'], bookmark['title'], bookmark['url']) }
  end

  def self.create(title, url_added)
    connection = if ENV['ENVIRONMENT'] == 'test'
                   PG.connect(dbname: 'bookmark_manager_test')
                 else
                   PG.connect(dbname: 'bookmark_manager')
                 end
    connection.exec("INSERT INTO bookmarks (title, url) VALUES('#{title}', '#{url_added}');")
  end

  def self.delete(title_delete)
    connection = if ENV['ENVIRONMENT'] == 'test'
                   PG.connect(dbname: 'bookmark_manager_test')
                 else
                   PG.connect(dbname: 'bookmark_manager')
                 end
    connection.exec("DELETE FROM bookmarks WHERE title = ('#{title_delete}');")
  end
end
