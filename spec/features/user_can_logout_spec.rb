require 'rails_helper'

describe 'A user signed in can log out' do
  before(:all) do
    OmniAuth.config.mock_auth[:github] = nil
    stub_omniauth 
  end
  it 'logs the user out' do
    visit '/'
    click_on 'Sign in with GitHub'
    visit '/repos'

    click_on 'Logout'

    expect(current_path).to eq('/')
    expect(page).to_not have_content('Logout')
    expect(page).to have_link('Sign in with GitHub')
  end
end
