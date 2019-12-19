require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'attributes' do
    it { should validate_presence_of :login }
    it { should validate_presence_of :token }
    it { should validate_uniqueness_of :login }
  end
end
