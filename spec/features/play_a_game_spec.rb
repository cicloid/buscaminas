RSpec.describe "Play a Game", js: true, type: :feature do

  it "shows a game" do
    visit '/'
    expect(page).to have_content 'Play a Game'
  end
end
