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
  end
  
  it 'signs me in and does not create a new user if i have logged in before' do
    user = create(:user, login: 'mockuser', token: 'mock_token')
    user_count = User.count
    
    visit root_path
    
    click_on 'Sign in with GitHub'
    
    expect(current_path).to eq('/repos')
    expect(page).to have_content('Logout')
    expect(page).to have_content("#{user.login}")
    
    expect(User.count).to eq(user_count)
  end
  
  it 'does not log in a user if github handshake fails' do
    visit root_path
    
    stub_omniauth_failure
    
    click_on 'Sign in with GitHub'

    expect(page).to have_content('Failed to connect to GitHub')

    expect(current_path).to eq(root_path)
  end
end
