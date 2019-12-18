require 'rails_helper'

describe 'As a user, when I click "Sign in with GitHub"' do
  it 'creates a new user and lets me login with GitHub' do
    visit '/'

    click_on "Sign in with GitHub"

    expect(current_path).to eq('/repos')
    expect(page).to have_content('Logout')

    user = User.last
    expect(user.token).to eq('mock_token')
    expect(user.login).to eq('mockuser')

    # users have attributes: username, github_token
  end

  it 'signs me in and does not create a new user if i have logged in before' do

  end
end
