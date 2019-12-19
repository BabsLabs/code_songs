require 'rails_helper'

describe 'As a user on the homepage' do
  it 'has welcome content' do
    visit '/'
    expect(page).to have_content("Welcome to")
    expect(page).to have_css("img[src*='/assets/codesongs_logo1_smaller']")
    expect(page).to have_link("Sign in with GitHub")

    within(".about") do
      expect(page).to have_content("About")
      expect(page).to have_css("#about-text")
    end
  end
end
