require 'pg'

feature 'Bookmark' do
  scenario 'Displays bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks VALUES(1,'http://www.makersacademy.com', 'Makers');")
    connection.exec("INSERT INTO bookmarks VALUES(2, 'http://www.destroyallsoftware.com', 'Destroy');")
    connection.exec("INSERT INTO bookmarks VALUES(3, 'http://www.google.com', 'Google');")

    visit('/bookmarks')

    expect(page).to have_content 'Google'
    expect(page).to have_content 'Destroy'
    expect(page).to have_content 'Makers'
  end
end

feature 'Adding Bookmarks' do
  scenario 'User to add bookmark via form' do
    PG.connect(dbname: 'bookmark_manager_test')
    Bookmark.create([title: 'Cinema'], [bookmark_url: 'http://www.odeon.com'])
    visit('/bookmarks')
    expect(page).to have_content 'Cinema'
  end
end

feature 'Follow Title Link' do
  scenario 'User clicks title and goes to respective URL' do
    PG.connect(dbname: 'bookmark_manager_test')
    visit('/bookmarks')
    fill_in :title, with: 'Cinema'
    fill_in :bookmark_url, with: 'http://www.odeon.com'
    click_on :Submit
    click_on :Cinema
    expect(page.current_url).to eq 'http://www.odeon.com/'
  end
end

feature 'Deleting Bookmarks' do
  scenario 'Deleting a bookmark' do
    PG.connect(dbname: 'bookmark_manager_test')
    visit('/bookmarks')
    fill_in :title, with: 'River Island'
    fill_in :bookmark_url, with: 'http://www.riverisland.com'
    click_on :Submit
    fill_in :title_delete, with: 'River Island'
    click_on :Delete
    expect(page).not_to have_content 'River Island'
  end
end


feature 'Updating Bookmarks' do
    scenario 'Update a bookmark by changing the url' do
      PG.connect(dbname: 'bookmark_manager_test')
      visit('/bookmarks')
      fill_in :title, with: 'River Island'
      fill_in :bookmark_url, with: 'http://www.riverisland.com'
      click_on :Submit
      fill_in :bookmark_to_update, with: 'River Island'
      fill_in :title_update, with: 'Island River'
      fill_in :url_update, with: 'http://www.riverisland.co.uk'
      click_on :Update
      expect(page).to have_content 'Island River'
    end
end
