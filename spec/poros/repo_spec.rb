require 'rails_helper'

describe 'Repo' do
  it 'makes a repo with a name' do
    repo = Repo.new({other_info: 'notimportant', name: 'my_repo'})

    expect(repo).to be_a(Repo)
    expect(repo.name).to eq('my_repo')
  end
end
